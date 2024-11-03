workspace("borepack")
    configurations({ "Debug", "Release" })
    architecture("x64")

project("borepack")
    kind("WindowedApp")
    language("C++")
    targetdir("bin/%{cfg.buildcfg}")

    -- Common include directories
    includedirs({ "deps/glad/include", "deps/glm", "deps/assimp/include", "src" })

    -- Common files
    files({
        "src/**.h",
        "src/**.cpp",
        "deps/glad/src/glad.cpp",
    })

    filter("configurations:Debug")
        defines({ "DEBUG" })
        symbols("On")

    filter("configurations:Release")
        defines({ "NDEBUG" })
        optimize("On")

    -- Linux-specific setup
    filter("system:linux")
        defines({ "LINUX" })
        buildoptions({ "-std=c++17", "-g", "-Wall", "-Wformat" })
        links({ "GL", "glfw", "assimp" })
        includedirs({ "/usr/include", "/usr/local/include" })
        libdirs({ "/usr/lib", "/usr/local/lib" })

    -- Windows-specific setup
    filter("system:windows")
        defines({ "WINDOWS" })
        buildoptions({ "/std:c++17" })
        links({ "opengl32.lib", "glfw3.lib", "assimp.lib" })
        includedirs({ "deps/glfw/include", "deps/assimp/include", "src" })
        libdirs({ "deps/glfw/lib", "deps/assimp/lib" })

    -- Reset filters
    filter({})
