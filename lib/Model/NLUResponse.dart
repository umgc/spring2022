import 'package:flutter/material.dart';
import 'package:untitled3/Model/NLUAction.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:untitled3/Model/NLUState.dart';

@JsonSerializable(nullable: true)
class NLUResponse {
  ActionType actionType;
  String? inputMessage;
  String? response;
  NLUState state;
  String? eventType;
  String? eventDate;
  String? eventTime;
  List<String>? resolvedValues;
  String? recurringType;
  String? timeOfDay;

  NLUResponse(this.actionType,
      this.inputMessage,
      this.response,
      this.state,
      this.eventType,
      this.eventDate,
      this.eventTime,
      this.resolvedValues,
      this.recurringType,
      this.timeOfDay);

  String toJson() {
    String jsonStr = """{"actionType": "${this.actionType}",
                        "inputMessage": "${this.inputMessage}",
                        "response": "${this.response}",
                        "state": "${this.state}",
                        "eventType": "${this.eventType}",
                        "eventDate": "${this.eventDate}", 
                        "eventTime": "${this.eventTime}", 
                        "resolvedValues": "${this.resolvedValues}",
                        "recurringType": "${this.recurringType}",
                        "timeOfDay": "${this.timeOfDay}"
                        """;
    return jsonStr;
  }
}