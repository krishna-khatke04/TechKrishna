package com.krishna.entity;

public class Messege {

    private String content;
    private String type;
    private String cssclass;

    public Messege(String content, String type, String cssclass) {
        this.content = content;
        this.type = type;
        this.cssclass = cssclass;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public void setType(String type) {
        this.type = type;
    }

    public void setCssclass(String cssclass) {
        this.cssclass = cssclass;
    }

    public String getContent() {
        return content;
    }

    public String getType() {
        return type;
    }

    public String getCssclass() {
        return cssclass;
    }

}
