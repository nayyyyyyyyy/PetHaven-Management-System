package com.pethaven.model;

public class Favourite {
    private int favouriteId;
    private int userId;
    private int petId;
    private String addedAt;
    private String petName;
    private String petType;
    private String petBreed;
    private String petStatus;
    private String petImageUrl;

    public Favourite() {}

    public int getFavouriteId() { return favouriteId; }
    public void setFavouriteId(int favouriteId) { this.favouriteId = favouriteId; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public int getPetId() { return petId; }
    public void setPetId(int petId) { this.petId = petId; }
    public String getAddedAt() { return addedAt; }
    public void setAddedAt(String addedAt) { this.addedAt = addedAt; }
    public String getPetName() { return petName; }
    public void setPetName(String petName) { this.petName = petName; }
    public String getPetType() { return petType; }
    public void setPetType(String petType) { this.petType = petType; }
    public String getPetBreed() { return petBreed; }
    public void setPetBreed(String petBreed) { this.petBreed = petBreed; }
    public String getPetStatus() { return petStatus; }
    public void setPetStatus(String petStatus) { this.petStatus = petStatus; }
    public String getPetImageUrl() { return petImageUrl; }
    public void setPetImageUrl(String petImageUrl) { this.petImageUrl = petImageUrl; }
}
