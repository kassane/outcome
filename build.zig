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
    const tests = b.option(bool, "Tests", "Build tests [default: false]") orelse false;

    const lib = b.addStaticLibrary(.{
        .name = "outcome",
        .target = target,
        .optimize = optimize,
    });
    lib.addIncludePath("include");
    lib.addCSourceFile("test/empty.cpp", &.{});
    lib.installHeadersDirectoryOptions(.{
        .source_dir = "single-header",
        .install_dir = .header,
        .install_subdir = "",
        .exclude_extensions = &.{
            "md",
            "experimental.hpp",
        },
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
        buildTest(b, .{
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
        if (!lib.target_info.target.isMusl()) {
            buildTest(b, .{
                .lib = lib,
                .path = "test/tests/issue0220.cpp",
            });
            buildTest(b, .{
                .lib = lib,
                .path = "test/tests/issue0255.cpp",
            });
        }
        buildTest(b, .{
            .lib = lib,
            .path = "test/tests/issue0259.cpp",
        });
    }
}

fn buildTest(b: *std.Build, info: BuildInfo) void {
    const test_exe = b.addExecutable(.{
        .name = info.filename(),
        .optimize = info.lib.optimize,
        .target = info.lib.target,
    });
    test_exe.addIncludePath("test/quickcpplib/include");
    test_exe.addIncludePath("test/quickcpplib/include/quickcpplib");
    test_exe.addCSourceFile(info.path, &.{
        "-Wall",
        "-Wextra",
    });
    test_exe.linkLibCpp();
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
    lib: *std.Build.CompileStep,
    path: []const u8,

    fn filename(self: BuildInfo) []const u8 {
        var split = std.mem.split(u8, std.fs.path.basename(self.path), ".");
        return split.first();
    }
};
