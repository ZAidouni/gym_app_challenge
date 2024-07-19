import 'package:cron/cron.dart';

class CronService {
  final cron = Cron();

  void start() {
    // Schedule a cron job to run every hour
    cron.schedule(Schedule.parse('0 * * * *'), () async {
      // Call your function to update session status here
      updateSessionStatus();
    });
  }

  void updateSessionStatus() {
    // Add your logic to update the status of the sessions
    print('Updating session status...');
    // For example, fetch sessions from a database and update their status
  }

  void stop() {
    cron.close();
  }
}
