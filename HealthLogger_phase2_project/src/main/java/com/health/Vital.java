package com.health;

public class Vital {
    private int id;
    private int patientid;
    private String name;
    private String phone;
    private int bplow;
    private int bphigh;
    private int spo2;
    private String  recordedtime;

    public Vital() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
    public int getPatientid() {
        return patientid;
    }

    public void setPatientid(int patientid) {
        this.patientid = patientid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public int getBpLow() {
        return bplow;
    }

    public void setBpLow(int bplow) {
        this.bplow = bplow;
    }

    public int getBpHigh() {
        return bphigh;
    }

    public void setBpHigh(int bphigh) {
        this.bphigh = bphigh;
    }

    public int getSpo2() {
        return spo2;
    }

    public void setSpo2(int spo2) {
        this.spo2 = spo2;
    }

    public String getRecordedTime() {
        return  recordedtime;
    }

    public void setRecordedTime(String  recordedtime) {
        this. recordedtime =  recordedtime;
    }
}
