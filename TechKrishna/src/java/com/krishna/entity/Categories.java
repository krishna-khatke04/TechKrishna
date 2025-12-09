/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.krishna.entity;

/**
 *
 * @author HP
 */
public class Categories {
    private int cid;
    private String  cname;
    private String cdescription;

    public Categories(int cid, String cname, String cdescription) {
        this.cid = cid;
        this.cname = cname;
        this.cdescription = cdescription;
    }

    public Categories() {
    }

    public Categories(String cname, String cdescription) {
        this.cname = cname;
        this.cdescription = cdescription;
    }

    public void setCid(int cid) {
        this.cid = cid;
    }

    public void setCname(String cname) {
        this.cname = cname;
    }

    public void setCdescription(String cdescription) {
        this.cdescription = cdescription;
    }

    public int getCid() {
        return cid;
    }

    public String getCname() {
        return cname;
    }

    public String getCdescription() {
        return cdescription;
    }
    
    
    
}
