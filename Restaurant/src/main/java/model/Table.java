package model;

public class Table {
    private int id;
    private int tableNumber;
    private int floor;
    private int capacity;
    private String description;

    // ===== Constructors =====
    public Table() {
    }

    public Table(int id, int tableNumber, int floor, int capacity, String description) {
        this.id = id;
        this.tableNumber = tableNumber;
        this.floor = floor;
        this.capacity = capacity;
        this.description = description;
    }
    
    public Table(String id, String tableNumber, String floor, String capacity, String description) {
        this.id = Integer.parseInt(id);
        this.tableNumber = Integer.parseInt(tableNumber);
        this.floor = Integer.parseInt(floor);
        this.capacity = Integer.parseInt(capacity);
        this.description = description;
    }

    // ===== Getters & Setters =====
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getTableNumber() {
        return tableNumber;
    }

    public void setTableNumber(int tableNumber) {
        this.tableNumber = tableNumber;
    }

    public int getFloor() {
        return floor;
    }

    public void setFloor(int floor) {
        this.floor = floor;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    // ===== toString() =====
    @Override
    public String toString() {
        return "Table{" +
                "id=" + id +
                ", tableNumber=" + tableNumber +
                ", floor=" + floor +
                ", capacity=" + capacity +
                ", description='" + description + '\'' +
                '}';
    }
}
