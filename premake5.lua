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
    -- Assumes you have glad.c in vendor/Glad/src and headers in vendor/Glad/include
    project "Glad"
        location "vendor/Glad"
        kind "StaticLib"
        language "C"
        staticruntime "on"

        targetdir ("bin/" .. outputdir .. "/%{prj.name}")
        objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

        files
        {
            "vendor/Glad/include/glad/glad.h",
            "vendor/Glad/include/KHR/khrplatform.h",
            "vendor/Glad/src/glad.c"
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
        "glfw3",
        "opengl32.lib"
    }

    -- Assuming you have pre-built GLFW binaries in vendor/GLFW/lib
    -- You might need to adjust this path depending on your VS version or build
    libdirs
    {
        "vendor/GLFW/lib"
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
