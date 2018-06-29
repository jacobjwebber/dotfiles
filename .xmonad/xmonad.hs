import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

main = do
    ixmproc <- spawnPipe "xmobar"
    xmonad $  defaultConfig
        {layoutHook=avoidStruts $ layoutHook defaultConfig
        , manageHook=manageHook defaultConfig <+> manageDocks
        }
