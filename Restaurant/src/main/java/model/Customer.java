/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class Customer extends User {

    public Customer() {
        super();
    }
    public Customer(int id, String name, String dob, String address, String email, String phone) {
        super();
        this.setId(id);
        this.setName(name);
        this.setDob(dob);
        this.setAddress(address);
        this.setEmail(email);
        this.setPhone(phone);
    }
}
