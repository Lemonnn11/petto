class LogEvent {
  Map<String, dynamic> action = {};
  static int logID = 0;
  static List<Map<String, dynamic>> logEvent = [];

  LogEvent() {
    logID += 1;
    action['logID'] = logID;
    action['dateTime'] = DateTime.now();
  }

  void setAction(String action) {
    this.action['action'] = action;
  }

  void setUserEmail(String email) {
    this.action['userEmail'] = email;
  }

  void addLog() {
    logEvent.add(action);
    print(action);
  }

  void showLogs() {
    print(logEvent);
  }
}
