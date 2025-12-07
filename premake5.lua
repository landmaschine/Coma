workspace "Coma"
    architecture "x64"
    startproject "Coma"

    configurations
    {
        "Debug",
        "Release",
        "Dist"
    }

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

-- Include directories relative to root folder (solution directory)
IncludeDir = {}
IncludeDir["GLFW"] = "vendor/GLFW/include"
IncludeDir["Glad"] = "vendor/Glad/include"

group "Dependencies"
    -- Project for Glad
    project "Glad"
        location "vendor/Glad"
        kind "StaticLib"
        language "C"
        staticruntime "on"

        targetdir ("bin/" .. outputdir .. "/%{prj.name}")
        objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

        files
        {
            "vendor/Glad/include/glad/gl.h",
            "vendor/Glad/include/glad/vulkan.h",
            "vendor/Glad/include/KHR/khrplatform.h",
            "vendor/Glad/src/gl.c",
            "vendor/Glad/src/vulkan.c"
        }

        includedirs
        {
            "vendor/Glad/include"
        }

        filter "configurations:Debug"
            runtime "Debug"
            symbols "on"

        filter "configurations:Release"
            runtime "Release"
            optimize "on"

        filter "configurations:Dist"
            runtime "Release"
            optimize "on"

    -- Project for GLFW
    project "GLFW"
        location "vendor/GLFW"
        kind "StaticLib"
        language "C"
        staticruntime "on"

        targetdir ("bin/" .. outputdir .. "/%{prj.name}")
        objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

        includedirs
        {
            "vendor/GLFW/include"
        }

        files
        {
            "vendor/GLFW/include/GLFW/glfw3.h",
            "vendor/GLFW/include/GLFW/glfw3native.h",
            "vendor/GLFW/src/context.c",
            "vendor/GLFW/src/init.c",
            "vendor/GLFW/src/input.c",
            "vendor/GLFW/src/monitor.c",
            "vendor/GLFW/src/platform.c",
            "vendor/GLFW/src/vulkan.c",
            "vendor/GLFW/src/window.c",
            "vendor/GLFW/src/egl_context.c",
            "vendor/GLFW/src/osmesa_context.c",
            "vendor/GLFW/src/null_init.c",
            "vendor/GLFW/src/null_joystick.c",
            "vendor/GLFW/src/null_monitor.c",
            "vendor/GLFW/src/null_window.c"
        }

        filter "system:windows"
            systemversion "latest"
            defines { "_GLFW_WIN32", "_CRT_SECURE_NO_WARNINGS" }
            files
            {
                "vendor/GLFW/src/win32_init.c",
                "vendor/GLFW/src/win32_joystick.c",
                "vendor/GLFW/src/win32_monitor.c",
                "vendor/GLFW/src/win32_time.c",
                "vendor/GLFW/src/win32_thread.c",
                "vendor/GLFW/src/win32_window.c",
                "vendor/GLFW/src/wgl_context.c",
                "vendor/GLFW/src/win32_module.c"
            }

        filter "configurations:Debug"
            runtime "Debug"
            symbols "on"

        filter "configurations:Release"
            runtime "Release"
            optimize "on"

        filter "configurations:Dist"
            runtime "Release"
            optimize "on"

group ""

project "Coma"
    location "Coma"
    kind "ConsoleApp"
    language "C++"
    cppdialect "C++17"
    staticruntime "on"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    files
    {
        "src/**.h",
        "src/**.cpp"
    }

    includedirs
    {
        "%{IncludeDir.GLFW}",
        "%{IncludeDir.Glad}"
    }

    links
    {
        "Glad",
        "GLFW",
        "opengl32.lib"
    }

    filter "system:windows"
        systemversion "latest"
        defines 
        { 
            "COMA_PLATFORM_WINDOWS",
            "GLFW_INCLUDE_NONE"
        }

    filter "configurations:Debug"
        defines "COMA_DEBUG"
        runtime "Debug"
        symbols "on"

    filter "configurations:Release"
        defines "COMA_RELEASE"
        runtime "Release"
        optimize "on"

    filter "configurations:Dist"
        defines "COMA_DIST"
        runtime "Release"
        optimize "on"
