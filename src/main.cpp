#include <glad/gl.h>
#include <GLFW/glfw3.h>
#include <iostream>

int main() {
    if (!glfwInit()) {
        std::cerr << "Failed to initialize GLFW" << std::endl;
        return -1;
    }

    std::cout << "Hello, Coma! GLFW initialized." << std::endl;

    glfwTerminate();
    return 0;
}
