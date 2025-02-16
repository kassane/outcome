const std = @import("std");

// Although this function looks imperative, note that its job is to
// declaratively construct a build graph that will be executed by an external
// runner.
pub fn build(b: *std.Build) void {
    // Standard target options allows the person running `zig build` to choose
    // what target to build for. Here we do not override the defaults, which
    // means any target is allowed, and the default is native. Other options
    // for restricting supported target set are available.
    const target = b.standardTargetOptions(.{});

    // Standard optimization options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall. Here we do not
    // set a preferred release mode, allowing the user to decide how to optimize.
    const optimize = b.standardOptimizeOption(.{});

    // Options
    // const shared = b.option(bool, "Shared", "Build the Shared Library [default: false]") orelse false;
    const tests = b.option(bool, "tests", "Build tests [default: false]") orelse false;

    const lib = b.addStaticLibrary(.{
        .name = "outcome",
        .target = target,
        .optimize = optimize,
    });
    lib.addIncludePath(b.path("include"));
    const empty_cpp = b.addWriteFile("empty.cpp", "// bypass for zig build");
    lib.addCSourceFiles(.{
        .root = empty_cpp.getDirectory(),
        .files = &.{"empty.cpp"},
    });
    lib.installHeadersDirectory(b.path("single-header"), "", .{
        .exclude_extensions = &.{ "md", "experimental.hpp" },
    });

    b.installArtifact(lib);

    if (tests) {
        buildTest(b, .{
            .lib = lib,
            .path = "test/single-header-test.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "test/constexprs/WG21_P1886a.cpp",
        });
        if (!lib.rootModuleTarget().isDarwin() and lib.rootModuleTarget().abi != .msvc)
            buildTest(b, .{
                .lib = lib,
                .path = "test/constexprs/max_result_get_value.cpp",
            });
        buildTest(b, .{
            .lib = lib,
            .path = "test/constexprs/min_result_get_value.cpp",
        });
        if (!lib.rootModuleTarget().isDarwin() and lib.rootModuleTarget().abi != .msvc)
            buildTest(b, .{
                .lib = lib,
                .path = "test/constexprs/max_result_construct_value_move_destruct.cpp",
            });
        buildTest(b, .{
            .lib = lib,
            .path = "test/constexprs/min_result_construct_value_move_destruct.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "test/tests/coroutine-support.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "test/tests/comparison.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "test/tests/constexpr.cpp",
        });
        if (!lib.rootModuleTarget().isDarwin()) buildTest(b, .{
            .lib = lib,
            .path = "test/tests/core-outcome.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "test/tests/core-result.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "test/tests/containers.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "test/tests/hooks.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "test/tests/fileopen.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "test/tests/default-construction.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "test/tests/propagate.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "test/tests/serialisation.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "test/tests/noexcept-propagation.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "test/tests/swap.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "test/tests/udts.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "test/tests/success-failure.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "test/tests/value-or-error.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "test/expected-pass.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "test/tests/issue0007.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "test/tests/issue0009.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "test/tests/issue0010.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "test/tests/issue0012.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "test/tests/issue0016.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "test/tests/issue0059.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "test/tests/issue0061.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "test/tests/issue0064.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "test/tests/issue0065.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "test/tests/issue0071.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "test/tests/issue0095.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "test/tests/issue0115.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "test/tests/issue0116.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "test/tests/issue0140.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "test/tests/issue0182.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "test/tests/issue0203.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "test/tests/issue0210.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "test/tests/issue0244.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "test/tests/issue0247.cpp",
        });
        if (!lib.rootModuleTarget().isMusl() and lib.rootModuleTarget().abi != .msvc) {
            buildTest(b, .{
                .lib = lib,
                .path = "include/outcome/experimental/status-code/test/issue0050.cpp",
            });
            buildTest(b, .{
                .lib = lib,
                .path = "test/tests/issue0220.cpp",
            });
            buildTest(b, .{
                .lib = lib,
                .path = "test/tests/issue0255.cpp",
            });
            buildTest(b, .{
                .lib = lib,
                .path = "include/outcome/experimental/status-code/test/result.cpp",
            });
            buildTest(b, .{
                .lib = lib,
                .path = "include/outcome/experimental/status-code/test/p0709a.cpp",
            });
            buildTest(b, .{
                .lib = lib,
                .path = "include/outcome/experimental/status-code/wg21/file_io_error.cpp",
            });
            buildTest(b, .{
                .lib = lib,
                .path = "test/tests/experimental-p0709a.cpp",
            });
            if (!lib.rootModuleTarget().isDarwin()) buildTest(b, .{
                .lib = lib,
                .path = "test/tests/experimental-core-outcome-status.cpp",
            });
            buildTest(b, .{
                .lib = lib,
                .path = "test/tests/experimental-core-result-status.cpp",
            });
        }
        if (lib.rootModuleTarget().abi != .msvc)
            buildTest(b, .{
                .lib = lib,
                .path = "test/tests/issue0259.cpp",
            });
    }
}

fn buildTest(b: *std.Build, info: BuildInfo) void {
    const test_exe = b.addExecutable(.{
        .name = info.filename(),
        .optimize = info.lib.root_module.optimize.?,
        .target = info.lib.root_module.resolved_target.?,
    });
    test_exe.addIncludePath(b.path("include/outcome/experimental/status-code/include"));
    test_exe.addIncludePath(b.path("test/quickcpplib/include"));
    test_exe.addIncludePath(b.path("test/quickcpplib/include/quickcpplib"));
    test_exe.addCSourceFile(.{
        .file = b.path(info.path),
        .flags = &.{
            "-Wall",
            "-Wextra",
        },
    });
    if (test_exe.rootModuleTarget().os.tag == .windows)
        test_exe.subsystem = .Console;
    if (test_exe.rootModuleTarget().abi == .msvc) {
        xWin(b, test_exe);
        test_exe.linkLibC();
    } else test_exe.linkLibCpp();
    b.installArtifact(test_exe);

    const run_cmd = b.addRunArtifact(test_exe);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step(
        b.fmt("{s}", .{info.filename()}),
        b.fmt("Run the {s} test", .{info.filename()}),
    );
    run_step.dependOn(&run_cmd.step);
}

const BuildInfo = struct {
    lib: *std.Build.Step.Compile,
    path: []const u8,

    fn filename(self: BuildInfo) []const u8 {
        var split = std.mem.splitSequence(u8, std.fs.path.basename(self.path), ".");
        return split.first();
    }
};

fn xWin(b: *std.Build, exe: *std.Build.Step.Compile) void {
    const arch: []const u8 = switch (exe.rootModuleTarget().cpu.arch) {
        .x86_64 => "x64",
        .x86 => "x86",
        .arm, .armeb => "arm",
        .aarch64 => "arm64",
        else => @panic("Unsupported Architecture"),
    };

    exe.setLibCFile(b.path(sdkPath("/libc.txt")));
    exe.addSystemIncludePath(b.path(sdkPath("/.xwin/crt/include")));
    exe.addSystemIncludePath(b.path(sdkPath("/.xwin/sdk/include")));
    exe.addSystemIncludePath(b.path(sdkPath("/.xwin/sdk/include/10.0.22000/cppwinrt")));
    exe.addSystemIncludePath(b.path(sdkPath("/.xwin/sdk/include/10.0.22000/ucrt")));
    exe.addSystemIncludePath(b.path(sdkPath("/.xwin/sdk/include/10.0.22000/um")));
    exe.addSystemIncludePath(b.path(sdkPath("/.xwin/sdk/include/10.0.22000/shared")));
    exe.addLibraryPath(b.path(b.fmt(sdkPath("/.xwin/crt/lib/{s}"), .{arch})));
    exe.addLibraryPath(b.path(b.fmt(sdkPath("/.xwin/sdk/lib/ucrt/{s}"), .{arch})));
    exe.addLibraryPath(b.path(b.fmt(sdkPath("/.xwin/sdk/lib/um/{s}"), .{arch})));
}

fn sdkPath(comptime suffix: []const u8) []const u8 {
    if (suffix[0] != '/') @compileError("relToPath requires an absolute path!");
    return comptime blk: {
        @setEvalBranchQuota(2000);
        const root_dir = std.fs.path.dirname(@src().file) orelse ".";
        break :blk root_dir ++ suffix;
    };
}
