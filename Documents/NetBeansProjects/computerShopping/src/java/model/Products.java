/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author Mickey
 */
public class Products implements java.io.Serializable{

    private String id;
    private String name;
    private String description;
    private double price;
    private String compatibility;
    private double powerConsumption;

    public Products() {

    }

    public Products(String id, String name, String description, double price) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
    }

    public Products(String id, String name, String description, double price, double powerConsumption) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.powerConsumption = powerConsumption;
    }

    public Products(String id, String name, String description, double price, String compatibility, double powerConsumption) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.compatibility = compatibility;
        this.powerConsumption = powerConsumption;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getCompatibility() {
        return compatibility;
    }

    public void setCompatibility(String compatibility) {
        this.compatibility = compatibility;
    }

    public double getPowerConsumption() {
        return powerConsumption;
    }

    public void setPowerConsumption(double powerConsumption) {
        this.powerConsumption = powerConsumption;
    }
}
