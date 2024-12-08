#include <iostream>
#include <cassert>
#include <chrono>
#include <curl/curl.h>

void test_compute_endpoint() {
    CURL* curl;
    CURLcode res;

    curl = curl_easy_init();
    if (curl) {
        curl_easy_setopt(curl, CURLOPT_URL, "http://127.0.0.1:8081/compute");
        curl_easy_setopt(curl, CURLOPT_HTTPGET, 1L);

        auto start_time = std::chrono::high_resolution_clock::now();

        res = curl_easy_perform(curl);

        auto end_time = std::chrono::high_resolution_clock::now();
        auto elapsed_time = std::chrono::duration_cast<std::chrono::seconds>(end_time - start_time).count();

        assert(res == CURLE_OK && "HTTP request failed");

        std::cout << "\nElapsed time: " << elapsed_time << " seconds\n";

        // Перевірка, що час виконання в межах 5-20 секунд
        assert(elapsed_time >= 5 && elapsed_time <= 20 && "Elapsed time is out of bounds");

        curl_easy_cleanup(curl);
    } else {
        assert(false && "Failed to initialize CURL");
    }
}

int main() {
    test_compute_endpoint();
    std::cout << "Test passed!\n";
    return 0;
}