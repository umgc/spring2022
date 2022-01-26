class LexResponse {
  late List<Interpretations> _interpretations;
  late List<Messages> _messages;
  late String _sessionId;
  late SessionState _sessionState;

  LexResponse({List<Interpretations>? interpretations, List<Messages>? messages, String? sessionId, SessionState? sessionState}) {
    this._interpretations = interpretations!;
    this._messages = messages!;
    this._sessionId = sessionId!;
    this._sessionState = sessionState!;
  }

  List<Interpretations> get interpretations => _interpretations;
  set interpretations(List<Interpretations> interpretations) => _interpretations = interpretations;
  List<Messages> get messages => _messages;
  set messages(List<Messages> messages) => _messages = messages;
  String get sessionId => _sessionId;
  set sessionId(String sessionId) => _sessionId = sessionId;
  SessionState get sessionState => _sessionState;
  set sessionState(SessionState sessionState) => _sessionState = sessionState;

  LexResponse.fromJson(Map<String, dynamic> json) {
    if (json['interpretations'] != null) {
      _interpretations =  <Interpretations>[];
      json['interpretations'].forEach((v) { _interpretations.add(new Interpretations.fromJson(v)); });
    }
    if (json['messages'] != null) {
      _messages = <Messages>[];
      json['messages'].forEach((v) { _messages.add(new Messages.fromJson(v)); });
    }
    _sessionId = json['sessionId'];
    _sessionState = (json['sessionState'] != null ? new SessionState.fromJson(json['sessionState']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._interpretations != null) {
      data['interpretations'] = this._interpretations.map((v) => v.toJson()).toList();
    }
    if (this._messages != null) {
      data['messages'] = this._messages.map((v) => v.toJson()).toList();
    }
    data['sessionId'] = this._sessionId;
    if (this._sessionState != null) {
      data['sessionState'] = this._sessionState.toJson();
    }
    return data;
  }
}

class Interpretations {
  late Intent _intent;
  late NluConfidence _nluConfidence;

  Interpretations({required Intent intent, required NluConfidence nluConfidence}) {
    this._intent = intent;
    this._nluConfidence = nluConfidence;
  }

  Intent get intent => _intent;
  set intent(Intent intent) => _intent = intent;
  NluConfidence get nluConfidence => _nluConfidence;
  set nluConfidence(NluConfidence nluConfidence) => _nluConfidence = nluConfidence;

  Interpretations.fromJson(Map<String, dynamic> json) {
    _intent = (json['intent'] != null ? new Intent.fromJson(json['intent']) : null)!;
    // _nluConfidence = (json['nluConfidence'] != null ? new NluConfidence.fromJson(json['nluConfidence']) : null);
    if (json['nluConfidence'] != null) {
      _nluConfidence = new NluConfidence.fromJson(json['nluConfidence']);
    } else {
      _nluConfidence = new NluConfidence(score: 0);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._intent != null) {
      data['intent'] = this._intent.toJson();
    }
    if (this._nluConfidence != null) {
      data['nluConfidence'] = this._nluConfidence.toJson();
    }
    return data;
  }
}

class Intent {
  late String _confirmationState;
  late String _name;
  late Slots _slots;
  late String _state;

  Intent({String? confirmationState, String? name, Slots? slots, String? state}) {
    this._confirmationState = confirmationState!;
    this._name = name!;
    this._slots = slots!;
    this._state = state!;
  }

  String get confirmationState => _confirmationState;
  set confirmationState(String confirmationState) => _confirmationState = confirmationState;
  String get name => _name;
  set name(String name) => _name = name;
  Slots get slots => _slots;
  set slots(Slots slots) => _slots = slots;
  String get state => _state;
  set state(String state) => _state = state;

  Intent.fromJson(Map<String, dynamic> json) {
     if (json['confirmationState'] != null) {
       _confirmationState = json['confirmationState'];
    }
     if (json['name'] != null ) {
       _name = json['name'];
     }
     if (json['slots'] != null ) {
       _slots = new Slots.fromJson(json['slots']);
     }
     if (json['state'] != null ) {
       _state = json['state'];
     }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['confirmationState'] = this._confirmationState;
    data['name'] = this._name;
    if (this._slots != null) {
      data['slots'] = this._slots.toJson();
    }
    data['state'] = this._state;
    return data;
  }
}

class Value {
  late String interpretedValue;
  late String originalValue;
  late List<String> resolvedValues;

  Value({required this.interpretedValue, required this.originalValue, required this.resolvedValues});

  Value.fromJson(Map<String, dynamic> json) {
    if (json['interpretedValue'] != null)
         interpretedValue = json['interpretedValue'];
    if (json['originalValue'] != null)
          originalValue = json['originalValue'];
    if (json['resolvedValues'] != null)
          resolvedValues = json['resolvedValues'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['interpretedValue'] = this.interpretedValue;
    data['originalValue'] = this.originalValue;
    data['resolvedValues'] = this.resolvedValues;
    return data;
  }
}


class EventType {
  late Value? value;

  EventType({required this.value});

  EventType.fromJson(Map<String, dynamic> json) {
    value = (json['value'] != null ? new Value.fromJson(json['value']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.value != null) {
      data['value'] = this.value!.toJson();
    }
    return data;
  }
}

class RecurringType {
  late Value? value;

  RecurringType({required this.value});

  RecurringType.fromJson(Map<String, dynamic> json) {
    value = json['value'] != null ? new Value.fromJson(json['value']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.value != null) {
      data['value'] = this.value!.toJson();
    }
    return data;
  }
}

class ActionEventType {
  late Value? value;

  ActionEventType({required this.value});

  ActionEventType.fromJson(Map<String, dynamic> json) {
    value = json['value'] != null ? new Value.fromJson(json['value']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.value != null) {
      data['value'] = this.value!.toJson();
    }
    return data;
  }
}

class AuxiliaryVerbType {
  late Value? value;

  AuxiliaryVerbType({required this.value});

  AuxiliaryVerbType.fromJson(Map<String, dynamic> json) {
    value = json['value'] != null ? new Value.fromJson(json['value']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.value != null) {
      data['value'] = this.value!.toJson();
    }
    return data;
  }
}

class HaveType {
  late Value? value;

  HaveType({required this.value});

  HaveType.fromJson(Map<String, dynamic> json) {
    value = json['value'] != null ? new Value.fromJson(json['value']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.value != null) {
      data['value'] = this.value!.toJson();
    }
    return data;
  }
}

class BeType {
  late Value? value;

  BeType({required this.value});

  BeType.fromJson(Map<String, dynamic> json) {
    value = json['value'] != null ? new Value.fromJson(json['value']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.value != null) {
      data['value'] = this.value!.toJson();
    }
    return data;
  }
}

class SubjectType {
  late Value? value;

  SubjectType({required this.value});

  SubjectType.fromJson(Map<String, dynamic> json) {
    value = json['value'] != null ? new Value.fromJson(json['value']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.value != null) {
      data['value'] = this.value!.toJson();
    }
    return data;
  }
}


class Slots {
  late EventType? eventType;
  late ActionEventType? actionEventType;
  late EventType? date;
  late EventType? time;
  late RecurringType? recurringType;
  late AuxiliaryVerbType? auxiliaryVerbType;
  late HaveType? haveType;
  late BeType? beType;
  late SubjectType? subjectType;

  Slots({this.eventType, this.date, this.time, this.recurringType, this.actionEventType, this.auxiliaryVerbType, this.haveType, this.beType, this.subjectType});

  Slots.fromJson(Map<String, dynamic> json) {
    if (json['EventType'] == null) {
      eventType = null;
    } else {
      eventType = new EventType.fromJson(json['EventType']);
    }
    if (json['ActionEventType'] == null) {
      actionEventType = null;
    } else {
      actionEventType = new ActionEventType.fromJson(json['ActionEventType']);
    }
    if (json['SubjectType'] == null) {
      subjectType = null;
    } else {
      subjectType = new SubjectType.fromJson(json['SubjectType']);
    }
    if (json['AuxiliaryVerbType'] == null) {
      auxiliaryVerbType = null;
    } else {
      auxiliaryVerbType = new AuxiliaryVerbType.fromJson(json['AuxiliaryVerbType']);
    }
    if (json['HaveType'] == null) {
      haveType = null;
    } else {
      haveType = new HaveType.fromJson(json['HaveType']);
    }
    if (json['BeType'] == null) {
      beType = null;
    } else {
      beType = new BeType.fromJson(json['BeType']);
    }
    if (json['RecurringType'] == null) {
      recurringType = null;
    } else {
      recurringType = new RecurringType.fromJson(json['RecurringType']);
    }
    if (json['Date'] == null) {
      date = null;
    } else {
      date = new EventType.fromJson(json['Date']);
    }
    if (json['Time'] == null) {
      time = null;
    } else {
      time = new EventType.fromJson(json['Time']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.eventType != null) {
      data['EventType'] = this.eventType!.toJson();
    }
    if (this.date != null) {
      data['Date'] = this.date;
    }
    if (this.time != null) {
      data['Time'] = this.time;
    }
    return data;
  }
}

class NluConfidence {
  late double _score;

  NluConfidence({required double score}) {
    this._score = score;
  }

  double get score => _score;
  set score(double score) => _score = score;

  NluConfidence.fromJson(Map<String, dynamic> json) {
    _score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['score'] = this._score;
    return data;
  }
}

class Messages {
  late String _content;
  late String _contentType;

  Messages({required String content, required String contentType}) {
    this._content = content;
    this._contentType = contentType;
  }

  String get content => _content;
  set content(String content) => _content = content;
  String get contentType => _contentType;
  set contentType(String contentType) => _contentType = contentType;

  Messages.fromJson(Map<String, dynamic> json) {
    _content = json['content'];
    _contentType = json['contentType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this._content;
    data['contentType'] = this._contentType;
    return data;
  }
}

class SessionState {
  late DialogAction _dialogAction;
  late Intent _intent;
  late String _originatingRequestId;

  SessionState({required DialogAction dialogAction, required Intent intent, required String originatingRequestId}) {
    this._dialogAction = dialogAction;
    this._intent = intent;
    this._originatingRequestId = originatingRequestId;
  }

  DialogAction get dialogAction => _dialogAction;
  set dialogAction(DialogAction dialogAction) => _dialogAction = dialogAction;
  Intent get intent => _intent;
  set intent(Intent intent) => _intent = intent;
  String get originatingRequestId => _originatingRequestId;
  set originatingRequestId(String originatingRequestId) => _originatingRequestId = originatingRequestId;

  SessionState.fromJson(Map<String, dynamic> json) {
    _dialogAction = (json['dialogAction'] != null ? new DialogAction.fromJson(json['dialogAction']) : null)!;
    _intent = (json['intent'] != null ? new Intent.fromJson(json['intent']) : null)!;
    _originatingRequestId = json['originatingRequestId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._dialogAction != null) {
      data['dialogAction'] = this._dialogAction.toJson();
    }
    if (this._intent != null) {
      data['intent'] = this._intent.toJson();
    }
    data['originatingRequestId'] = this._originatingRequestId;
    return data;
  }
}

class DialogAction {
  late String _type;

  DialogAction({required String type}) {
    this._type = type;
  }

  String get type => _type;
  set type(String type) => _type = type;

  DialogAction.fromJson(Map<String, dynamic> json) {
    _type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this._type;
    return data;
  }
}