
class EmergencyReport {
    EmergencyReport({
        this.id,
        this.reportCase,
        this.reportDriver,
        this.reportNotes,
        this.reportStatus,
        this.reportAttachment,
    });

    String? id;
    String? reportCase;
    String? reportDriver;
    String? reportNotes;
    String? reportStatus;
    dynamic reportAttachment;

    factory EmergencyReport.fromJson(Map<String, dynamic> json) => EmergencyReport(
        id: json["id"],
        reportCase: json["report_case"],
        reportDriver: json["report_driver"],
        reportNotes: json["report_notes"],
        reportStatus: json["report_status"],
        reportAttachment: json["report_attachment"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "report_case": reportCase,
        "report_driver": reportDriver,
        "report_notes": reportNotes,
        "report_status": reportStatus,
        "report_attachment": reportAttachment,
    };
}