#include "clientmanager.h"

 void CLientManager::createDatabaseStructure() {
        pqxx::work W(conn);
        W.exec("CREATE TABLE IF NOT EXISTS clients ("
               "id SERIAL PRIMARY KEY, "
               "first_name VARCHAR(50), "
               "last_name VARCHAR(50), "
               "email VARCHAR(100) UNIQUE NOT NULL);");
        W.exec("CREATE TABLE IF NOT EXISTS phones ("
               "id SERIAL PRIMARY KEY, "
               "client_id INTEGER REFERENCES clients(id) ON DELETE CASCADE, "
               "phone VARCHAR(20));");
        W.commit();
    }

  void CLientManager::addClient(const std::string& firstName, const std::string& lastName, const std::string& email) {
        pqxx::work W(conn);
        W.exec_params("INSERT INTO clients (first_name, last_name, email) VALUES ($1, $2, $3);",
                      firstName, lastName, email);
        W.commit();
    }

    void CLientManager::addPhone(int clientId, const std::string& phone) {
        pqxx::work W(conn);
        W.exec_params("INSERT INTO phones (client_id, phone) VALUES ($1, $2);", clientId, phone);
        W.commit();
    }

    void CLientManager::updateClient(int clientId, const std::string& firstName, const std::string& lastName, const std::string& email) {
        pqxx::work W(conn);
        W.exec_params("UPDATE clients SET first_name = $1, last_name = $2, email = $3 WHERE id = $4;",
                      firstName, lastName, email, clientId);
        W.commit();
    }

    void CLientManager::deletePhone(int phoneId) {
        pqxx::work W(conn);
        W.exec_params("DELETE FROM phones WHERE id = $1;", phoneId);
        W.commit();
    }

  void CLientManager::deleteClient(int clientId) {
        pqxx::work W(conn);
        W.exec_params("DELETE FROM clients WHERE id = $1;", clientId);
        W.commit();
    }

    void CLientManager::findClient(const std::string& searchTerm) {
        pqxx::work W(conn);
        pqxx::result R = W.exec_params(
            "SELECT c.id, c.first_name, c.last_name, c.email, p.phone FROM clients c "
            "LEFT JOIN phones p ON c.id = p.client_id "
            "WHERE c.first_name ILIKE $1 OR c.last_name ILIKE $1 OR c.email ILIKE $1 OR p.phone ILIKE $1;",
            "%" + searchTerm + "%");

        for (const auto& row : R) {
            std::cout << "ID: " << row["id"].as<int>()
                      << ", First Name: " << row["first_name"].c_str()
                      << ", Last Name: " << row["last_name"].c_str()
                      << ", Email: " << row["email"].c_str()
                      << ", Phone: " << (row["phone"].is_null() ? "None" : row["phone"].c_str())
                      << std::endl;
        }
    }
