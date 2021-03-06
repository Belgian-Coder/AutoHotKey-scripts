# Pin Window Script - Bottom Right

Script created to extend the functionality of the Chrome [Enhancer for YouTube](https://chrome.google.com/webstore/detail/enhancer-for-youtube/ponfpcnoihfmfllpaingbgckeeldkhle) extension. Forementioned Chrome extension, makes it possible to automatically resize your video player window or change the default video quality to your liking. There are a lot more functionalities but the one this script extends, is the Pop-out function. By popping out the video, it can be dragged along the screen without any distractions and positioned to your liking. 

## Functionality

Execute the script through the AutoHotKey software or open the compiled binary. Navigate to any YouTube video and use Enhancer for Youtube to pop-out the video. Select the new window and press the `windows + spacebar` keys. This combination will resize the window depending on your screen size and place it in the right corner at the bottom of your primary screen. From now on, you can open other windows but the YouTube window will always stay on top and will stay visible. You can still resize or drag the window to another location, the on top functionality will stay active. To Deactivate the functionality you can just close the video window or select the YouTube window by clicking on the title bar and pressing the `windows + spacebar` shortcut again.

## Tips

Maximizing your screen space is easier with [PowerToys](https://github.com/microsoft/PowerToys/releases) for Windows 10. By creating FancyZones, you can change your snapping spaces to surround the YouTube Window. Have fun watching those videos!

# Pin Windows - Bottom Right - fancyZone

A customized script to combine the functionallity to keep windows always on top with zone placement through FancyZones from Microsoft Powertoys. More information can be found in the script file.

## Functionality

All key combinations will only work in combination with designated zones in FancyZones as explained in the script file. Width and height of the zones do not influence functionality. You need to enable the "Override Windows Snap shortcut (Win + Arrow) to move windows between zones" setting in PowerToys. List of possible combinations:

- `windows + alt + up` => maximize the active window
- `windows + alt + left` => move and resize the active window to the left large zone
- `windows + alt + right` => move and resize the active window to the upper right zone
- `windows + alt + down` => move and resize the active window to the lower right zone
- `windows + alt + y` => move and resize the active window to the lower right zone and force it to always stay on top
- `windows + alt + space` => toggle to force the active window to always stay on top