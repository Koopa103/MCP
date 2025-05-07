package com.example;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import com.fasterxml.jackson.datatype.jsr353.JSR353Module;
import com.anthropic.models.messages.ToolUseBlock;
import javax.json.JsonValue;
import com.anthropic.core.JsonField;

public class JsonSerializer {
    public static String serializeToJson(String input) throws JsonProcessingException {
        ObjectMapper mapper = new ObjectMapper();
        // Enable various configuration options
        return mapper.writeValueAsString(input);
    }

    public static String convertJsonValueToString(JsonValue jsonValue) throws JsonProcessingException {
        ObjectMapper mapper = new ObjectMapper();
        
        // Register the JSR-353 (Java API for JSON Processing) module
        mapper.registerModule(new JSR353Module());
        
        // Directly serialize the JsonValue
        return mapper.writeValueAsString(jsonValue);
    }


    public static String convertToolUseBlockToJson(ToolUseBlock toolUseBlock) throws JsonProcessingException {
        ObjectMapper mapper = new ObjectMapper();
        return mapper.writeValueAsString(toolUseBlock);
    }

}
