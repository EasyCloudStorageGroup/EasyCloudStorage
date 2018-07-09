package com.easycloudstorage.pojo;

public class NormalFile extends File {
    private int fileId;
    private String type;
    private String size;
    private String sortType;

    public int getFileId() {
        return fileId;
    }

    public void setFileId(int fileId) {
        this.fileId = fileId;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getSortType(){
        this.type=this.type.toLowerCase();
        if(this.type.equals("image/jpg")||this.type.equals("image/png")||this.type.equals("image/gif")||this.type.equals("image/bmp")||
                this.type.equals("image/tiff"))
            return "Picture";
        else if(this.type.equals("mp4")||this.type.equals("dat")||this.type.equals("mpg")||this.type.equals("mpeg"))
            return "Vedio";
        else if(this.type.equals("mp3")||this.type.equals("wmv")||this.type.equals("ape"))
            return "Music";
        else    return "Other";
    }
}
