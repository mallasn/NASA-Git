global class SendOppToEHBScheduler implements Schedulable {
	global void execute(SchedulableContext sc) {
		SendOppToEHBBatch b = new SendOppToEHBBatch();
		database.executebatch(b,10);
	}
}