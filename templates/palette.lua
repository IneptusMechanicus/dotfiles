local M = {}

M.palette = {
  main = {
    os.getenv("COLOR_00"),
    os.getenv("COLOR_01"),
    os.getenv("COLOR_02"),
    os.getenv("COLOR_03"),
    os.getenv("COLOR_04"),
    os.getenv("COLOR_05"),
    os.getenv("COLOR_06"),
    os.getenv("COLOR_07"),
  },
  bright = {
    os.getenv("COLOR_08"),
    os.getenv("COLOR_09"),
    os.getenv("COLOR_10"),
    os.getenv("COLOR_11"),
    os.getenv("COLOR_12"),
    os.getenv("COLOR_13"),
    os.getenv("COLOR_14"),
    os.getenv("COLOR_15"),
  }
}

return M
