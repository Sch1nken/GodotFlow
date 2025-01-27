# GodotFlow

![Preview](preview.gif)

This is a rough recreation of the [Wiiflow](https://github.com/Fledge68/WiiFlow_Lite) carousel in Godot.
Uses features from Godot 4.4 (Typed dictionaries). It is easy to adapt to not use typed dictionaries though (to work on versions < 4.4)

A lot of stuff is not implemented (different "views" like multiple rows), no transparent games near the edges, no vfx in the background, the bottom mirror is a fake (and does not support blur).
I did not bother to implement FOV for other aspect ratios (though Wiiflow provides code for this and I copied the relevant part into wiiflow.gd)
Most stuff is configurable via the two layout settings in the filesystem (layout_settings_normal / layout_settings_selected) which change the properties of the scene during normal and selected states respectively.
Though some values might have no effect because the logic for them is not implemented.

This software is provided as is and does not represent good practice for Godot development.

# Controls
Left (ui_left) / Right (ui_right) arrow to scroll
Enter (ui_accept) to select
Esc (ui_cancel) to deselect