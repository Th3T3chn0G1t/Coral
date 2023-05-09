local CoralDotNetPath = os.getenv("CORAL_DOTNET_PATH")

project "Testing"
    language "C++"
    cppdialect "C++20"
    kind "ConsoleApp"

    -- Can't specify 64-bit architecture in the workspace level since VS 2022 (see https://github.com/premake/premake-core/issues/1758)
    architecture "x86_64"

    files {
        "Source/**.cpp",
        "Source/**.hpp",
    }

    externalincludedirs { "../Coral.Native/Include/" }

    libdirs { CoralDotNetPath }

    links {
        "Coral.Native",

        "nethost",
        "libnethost",
        "ijwhost",
    }

    postbuildcommands {
        '{ECHO} Copying "' .. CoralDotNetPath .. '/nethost.dll" to "%{cfg.targetdir}"',
        '{COPYFILE} "' .. CoralDotNetPath .. '/nethost.dll" "%{cfg.targetdir}"',
    }

    filter { "configurations:Debug" }
        defines { "CORAL_TESTING_DEBUG" }

    filter { "configurations:Release" }
        defines { "CORAL_TESTING_RELEASE" }