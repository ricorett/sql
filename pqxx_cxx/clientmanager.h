#pragma once
#include <pqxx/pqxx>
#include <iostream>

class CLientManager{
    public:
        CLientManager(const std::string& connectionString) : conn(connectionString){}
        void createDatabaseStructure();
        void addClient(const std::string& firstName, const std::string& lastName, const std::string& email);
        void addPhone(int clientId, const std::string& phone);
        void updateClient(int clientId, const std::string& firstName, const std::string& lastName, const std::string& email);
        void deletePhone(int phoneId);
        void deleteClient(int clientId);
        void findClient(const std::string& searchTerm);
    
    private:
    pqxx::connection conn;
};