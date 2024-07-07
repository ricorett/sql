#include "clientmanager.h"


int main() {
    try {
        CLientManager manager("dbname=client_manager user=postgres password=123 hostaddr=127.0.0.1 port=5432");

        manager.createDatabaseStructure();

        manager.addClient("John", "Doe", "john.doe@example.com");
        manager.addClient("Jane", "Smith", "jane.smith@example.com");

        manager.addPhone(1, "+1234567890");
        manager.addPhone(1, "+0987654321");

        manager.updateClient(2, "Jane", "Doe", "jane.doe@example.com");

        manager.deletePhone(2);

        manager.findClient("Doe");

        manager.deleteClient(1);

    } catch (const std::exception &e) {
        std::cerr << e.what() << std::endl;
        return 1;
    }

    return 0;
}