import org.junit.*;
import java.nio.file.*;
import java.sql.*;
import java.util.*;

import static org.hamcrest.CoreMatchers.*;
import static org.hamcrest.MatcherAssert.assertThat;

public class SqlSystemTest {

    private static Connection cnn;

    /** Run once, before all tests. */
    @BeforeClass
    public static void bootDatabase() throws Exception {
        Class.forName("org.sqlite.JDBC");                 // make sure the driver is loaded
        cnn = DriverManager.getConnection("jdbc:sqlite::memory:");   // brand-new DB in RAM

        // run the table definitions then the view definitions
        runSql("sql/Database.sql");
        runSql("sql/Views.sql");
    }

    /** Execute every statement contained in the given class-path resource. */
    private static void runSql(String classpathResource) throws Exception {
        String sql = Files.readString(Paths.get(
                SqlSystemTest.class.getResource(classpathResource).toURI()));

        // “GO” batch separators are left over from SQL Server – SQLite doesn’t know them.
        sql = sql.replaceAll("(?mi)^\\s*GO\\s*$", "");

        try (Statement st = cnn.createStatement()) {
            st.executeUpdate(sql);
        }
    }

    @AfterClass
    public static void tearDown() throws Exception {
        if (cnn != null) cnn.close();
    }

    /* ─────────── ACTUAL TESTS ─────────── */

    @Test
    public void representativeViewSchemaPresent() throws Exception {
        // pick one of the views declared in Views.sql
        DatabaseMetaData md = cnn.getMetaData();
        try (ResultSet rs = md.getTables(null, null, "vw_student_classes", null)) {
            assertThat("vw_student_classes view must exist",
                       rs.next(), is(true));
        }
    }

    @Test
    public void whereAndLimitExecute() throws Exception {
        // PRAGMA off by default, but make sure foreign-key checks don't surprise us
        try (Statement st = cnn.createStatement()) {
            st.execute("PRAGMA foreign_keys = OFF");
        }

        /* ── seed minimal reference data ───────────────────────────── */
        try (Statement st = cnn.createStatement()) {
            st.executeUpdate(
                "INSERT INTO department (id, name) VALUES ('CS', 'Computer Science')");

            st.executeUpdate(
                "INSERT INTO course (id, department, title, num, hrs) " +
                "VALUES ('CSC-101','CS','Intro-1',101,3)");
            st.executeUpdate(
                "INSERT INTO course (id, department, title, num, hrs) " +
                "VALUES ('CSC-102','CS','Intro-2',102,3)");
        }

        /* ── exercise WHERE + LIMIT on the real table ──────────────── */
        String sql = "SELECT * FROM students";
        try (PreparedStatement ps = cnn.prepareStatement(sql)) {
            ps.setString(1, "CSC-102");
            try (ResultSet rs = ps.executeQuery()) {
                assertThat("row present", rs.next(), is(true));
                assertThat(rs.getString(1), equalTo("CSC-102"));
                assertThat("LIMIT 1 returns only one row", rs.next(), is(false));
            }
        }
    }
}
