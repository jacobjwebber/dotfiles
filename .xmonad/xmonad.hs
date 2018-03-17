import XMonad
import XMonad.Config.Desktop
import XMonad.Util.EZConfig
import Graphics.X11.ExtraTypes.XF86

main = do
    spawn "xmobar"
    xmonad $ desktopConfig
        { borderWidth = 1
        , terminal = "lxterminal"
        } `additionalKeys` 
            [ ((0, xF86XK_AudioLowerVolume   ), spawn "amixer set Master 2-")
            , ((0, xF86XK_AudioRaiseVolume   ), spawn "amixer set Master 2+")
            , ((0, xF86XK_AudioMute          ), spawn "amixer set Master toggle")
            ]
