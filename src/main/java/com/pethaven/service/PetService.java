package com.pethaven.service;

import com.pethaven.model.Pet;
import java.util.ArrayList;

/**
 * PetService - Contains all business logic and DSA algorithms
 * This replaces most of your old PetController.java
 */
public class PetService {

    // ==========================================================
    // 1. SEARCH ALGORITHMS
    // ==========================================================

    /**
     * Binary Search by Pet ID (Requires sorted list by ID)
     */
    public int binarySearchByID(ArrayList<Pet> list, int targetId) {
        int low = 0;
        int high = list.size() - 1;

        while (low <= high) {
            int mid = (low + high) / 2;
            if (list.get(mid).getPetId() == targetId) {
                return mid;
            } else if (list.get(mid).getPetId() < targetId) {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return -1; // Not found
    }

    // ==========================================================
    // 2. SORTING ALGORITHMS
    // ==========================================================

    /**
     * Selection Sort - Sort by Pet ID
     */
    public void sortByID(ArrayList<Pet> list) {
        for (int i = 0; i < list.size() - 1; i++) {
            int minIdx = i;
            for (int j = i + 1; j < list.size(); j++) {
                if (list.get(j).getPetId() < list.get(minIdx).getPetId()) {
                    minIdx = j;
                }
            }
            // Swap
            Pet temp = list.get(i);
            list.set(i, list.get(minIdx));
            list.set(minIdx, temp);
        }
    }

    /**
     * Insertion Sort - Sort by Name (Alphabetically)
     */
    public void sortByName(ArrayList<Pet> list) {
        for (int i = 1; i < list.size(); i++) {
            Pet key = list.get(i);
            int j = i - 1;
            while (j >= 0 && list.get(j).getName().compareToIgnoreCase(key.getName()) > 0) {
                list.set(j + 1, list.get(j));
                j--;
            }
            list.set(j + 1, key);
        }
    }

    /**
     * Merge Sort - Sort by Age
     */
    public void sortByAge(ArrayList<Pet> list) {
        if (list.size() <= 1) return;

        int mid = list.size() / 2;
        ArrayList<Pet> left = new ArrayList<>(list.subList(0, mid));
        ArrayList<Pet> right = new ArrayList<>(list.subList(mid, list.size()));

        sortByAge(left);
        sortByAge(right);
        merge(list, left, right);
    }

    private void merge(ArrayList<Pet> list, ArrayList<Pet> left, ArrayList<Pet> right) {
        int i = 0, j = 0, k = 0;
        while (i < left.size() && j < right.size()) {
            if (left.get(i).getAge() <= right.get(j).getAge()) {
                list.set(k++, left.get(i++));
            } else {
                list.set(k++, right.get(j++));
            }
        }
        while (i < left.size()) list.set(k++, left.get(i++));
        while (j < right.size()) list.set(k++, right.get(j++));
    }

    // ==========================================================
    // 3. Helper Methods
    // ==========================================================

    /**
     * Returns a copy of the list (useful before sorting)
     */
    public ArrayList<Pet> getCopy(ArrayList<Pet> list) {
        return new ArrayList<>(list);
    }
}