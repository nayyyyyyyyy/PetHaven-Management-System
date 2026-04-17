package com.pethaven.model;

public class Pet {
    private int petId;
    private String name;
    private int age;
    private String breed;
    private String type;
    private String gender;
    private String status;
    private String description;
    private int addedBy;
    private String imageUrl;

    public Pet() {}

    // Constructor used by PetDAO and AlgorithmUtils
    public Pet(int petId, String name, int age, String breed, String type, String gender, String status, String description, int addedBy) {
        this.petId = petId;
        this.name = name;
        this.age = age;
        this.breed = breed;
        this.type = type;
        this.gender = gender;
        this.status = status;
        this.description = description;
        this.addedBy = addedBy;
    }

    // Getters and Setters
    public int getPetId() { return petId; }
    public void setPetId(int petId) { this.petId = petId; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public int getAge() { return age; }
    public void setAge(int age) { this.age = age; }
    public String getBreed() { return breed; }
    public void setBreed(String breed) { this.breed = breed; }
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public int getAddedBy() { return addedBy; }
    public void setAddedBy(int addedBy) { this.addedBy = addedBy; }
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
}