{ pkgs, ... }:

{
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.oreo-cursors-plus.override {
      cursorsConf = ''
# Oreo Cursor Generator - Generate your own cursors

# Long Syntax with Attributes
# purple = colour: #ff5, label: #fa0, shadow: #0a0, shadow_opacity: 1, stroke: #08f, stroke_opacity: 1.2, stroke_width: 1.5
# purple = color: #ff5, label: #fa0, shadow: #0a0, shadow_opacity: 1, stroke: #08f, stroke_opacity: 1.2, stroke_width: 1.5

# All the options can be shuffled!
# "_" can be replaced with "-". For example, "stroke_opacity" can be written as "stroke-opacity".
# "colour" can be replaced with "color", For example, "colour: #55f" can be written as "color: #55f".
# ":" can be replaced with "=". For example, "stroke-width: 1" can be written as "stroke-width = 1".

# If you want to generate a single colour with the default value for others
# purple = #fff

# Sizes to build (defaults to 32, 64 if not defined)
sizes = 24, 32, 40, 48, 56, 64

# Default cursors by Varlesh
black = #424242
blue = #4E81ED
grey = #546E7A
pink = #EE5387
purple = #7E57C2
red = #F44336
teal = #009789
white = colour: #C6C6C6, label: #424242

# Spark cursors: More colours by Sourav
spark_red = #f55
spark_blue = #55f
spark_pink = #ff50a6
spark_orange = #FFA726
spark_green = #4E9A06
spark_purple = #912BFF
spark_lime = colour: #E7EC00, label: #2e7d32
spark_light_pink = #ff91c7
spark_violet = #6435C9

# Spark cursors with Borders
spark_red_bordered = color: #f55, stroke: #fff, stroke-width: 1, stroke-opacity: 1
spark_blue_bordered = color: #55f, stroke: #fff, stroke-width: 1, stroke-opacity: 1
spark_pink_bordered = color: #ff50a6, stroke: #fff, stroke-width: 1, stroke-opacity: 1
spark_orange_bordered = color: #FFA726, stroke: #fff, stroke-width: 1, stroke-opacity: 1
spark_green_bordered = color: #4E9A06, stroke: #fff, stroke-width: 1, stroke-opacity: 1
spark_purple_bordered = color: #912BFF, stroke: #fff, stroke-width: 1, stroke-opacity: 1
spark_lime_bordered = color: #E7EC00, label: #2e7d32, stroke: #2e7d32, stroke-width: 1, stroke-opacity: 1
spark_light_pink_bordered = color: #ff91c7, stroke: #fff, stroke-width: 1, stroke-opacity: 1
spark_violet_bordered = color: #6435C9, stroke: #fff, stroke-width: 1, stroke-opacity: 1
spark_light_blue_bordered = color: #6a94ff, stroke: #fff, stroke-width: 1, stroke-opacity: 1
spark_light_turquoise_bordered = color: #3ce3b4, stroke: #fff, stroke-width: 1, stroke-opacity: 1
spark_medium_cyan_bordered = color: #00d2d2, stroke: #fff, stroke-width: 1, stroke-opacity: 1
spark_vibrant_pink_bordered = color: #f0417d, stroke: #fff, stroke-width: 1, stroke-opacity: 1
spark_neon_pink_bordered = color: #fb5fdc, stroke: #fff, stroke-width: 1, stroke-opacity: 1
spark_vibrant_violet_magenta_bordered = color: #aa33ff, stroke: #fff, stroke-width: 1, stroke-opacity: 1
spark_vivid_orange_bordered = color: #ffa500, stroke: #fff, stroke-width: 1, stroke-opacity: 1
spark_spring_green_bordered = color: #00ff7f, stroke: #fff, stroke-width: 1, stroke-opacity: 1
spark_spring_green_deep_bordered = color: #26d07c, stroke: #fff, stroke-width: 1, stroke-opacity: 1
spark_jungle_green_bordered = color: #2aaa8a, stroke: #fff, stroke-width: 1, stroke-opacity: 1
spark_light_sea_green_bordered = color: #20b2aa, stroke: #fff, stroke-width: 1, stroke-opacity: 1

# Spark white and black Cursors with Borders:
spark_black_bordered = color: #000, stroke: #fff, stroke-width: 1, stroke-opacity: 1
spark_white_bordered = color: #fff, label: #222, stroke: #222, stroke-opacity: 1, stroke-width: 1
      '';
    };
    name = "test";
    size = 18;
  };
}
