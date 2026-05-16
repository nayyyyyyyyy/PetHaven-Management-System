package com.pethaven.model;

// MODEL LAYER: This is the domain/data class for a Pet entity.
// It maps directly to the 'pets' table in the MySQL database.
// Fully encapsulated — all fields are private, accessed via getters/setters only.

public class Pet {

    // FIELDS: These match the columns in the 'pets' table in pethaven_db
    private int    petId;
    private String name;
    private String breed;
    private int    age;
    private String status;      // e.g. "Available", "Adopted"
    private String type;        // e.g. "Dog", "Cat", "Bird"
    private String gender;
    private String description;
    private int    addedBy;     // foreign key — which admin added this pet
    private String imageUrl;    // optional URL for pet photo

    // DEFAULT CONSTRUCTOR: Required by JDBC result-set mapping in PetDAO
    public Pet() {}

    // PARAMETERISED CONSTRUCTOR: Used when building a Pet object from a DB row
    // Coursework requires: petID, name, breed, age, status as minimum fields
    public Pet(int petId, String name, String breed, int age, String status) {
        this.petId  = petId;
        this.name   = name;
        this.breed  = breed;
        this.age    = age;
        this.status = status;
    }

    // FULL CONSTRUCTOR: Used internally by PetDAO when loading all columns
    public Pet(int petId, String name, int age, String breed,
               String type, String gender, String status,
               String description, int addedBy) {
        this.petId       = petId;
        this.name        = name;
        this.age         = age;
        this.breed       = breed;
        this.type        = type;
        this.gender      = gender;
        this.status      = status;
        this.description = description;
        this.addedBy     = addedBy;
    }

    // GETTERS & SETTERS: Standard encapsulation — no direct field access from outside
    public int    getPetId()                  { return petId; }
    public void   setPetId(int petId)         { this.petId = petId; }

    public String getName()                   { return name; }
    public void   setName(String name)        { this.name = name; }

    public String getBreed()                  { return breed; }
    public void   setBreed(String breed)      { this.breed = breed; }

    public int    getAge()                    { return age; }
    public void   setAge(int age)             { this.age = age; }

    public String getStatus()                 { return status; }
    public void   setStatus(String status)    { this.status = status; }

    public String getType()                   { return type; }
    public void   setType(String type)        { this.type = type; }

    public String getGender()                 { return gender; }
    public void   setGender(String gender)    { this.gender = gender; }

    public String getDescription()                      { return description; }
    public void   setDescription(String description)    { this.description = description; }

    public int    getAddedBy()                { return addedBy; }
    public void   setAddedBy(int addedBy)     { this.addedBy = addedBy; }

    public String getImageUrl()               { return imageUrl; }
    public void   setImageUrl(String imageUrl){ this.imageUrl = imageUrl; }

    // toString: Handy for debugging — prints a readable summary of the pet
    @Override
    public String toString() {
        return "Pet{id=" + petId + ", name='" + name + "', breed='" + breed
             + "', age=" + age + ", status='" + status + "'}";
    }
}
