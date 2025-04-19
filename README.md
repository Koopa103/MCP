




How to run the MCP server, also export an api key somehow `ANTHROPIC_API_KEY` should be it's name


```
mvn clean compile spring-boot:run -Dspring-boot.run.profiles=dev,local 

```


```
mvn exec:java -Dexec.mainClass="com.example.McpClientExample"

```



