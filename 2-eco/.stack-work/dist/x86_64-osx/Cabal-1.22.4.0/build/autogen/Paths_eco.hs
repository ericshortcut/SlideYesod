module Paths_eco (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [0,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/eric/Desktop/test/apresentacao/2-eco/.stack-work/install/x86_64-osx/lts-3.9/7.10.2/bin"
libdir     = "/Users/eric/Desktop/test/apresentacao/2-eco/.stack-work/install/x86_64-osx/lts-3.9/7.10.2/lib/x86_64-osx-ghc-7.10.2/eco-0.0.0-JgtybVCaQq456HlpEd5xOf"
datadir    = "/Users/eric/Desktop/test/apresentacao/2-eco/.stack-work/install/x86_64-osx/lts-3.9/7.10.2/share/x86_64-osx-ghc-7.10.2/eco-0.0.0"
libexecdir = "/Users/eric/Desktop/test/apresentacao/2-eco/.stack-work/install/x86_64-osx/lts-3.9/7.10.2/libexec"
sysconfdir = "/Users/eric/Desktop/test/apresentacao/2-eco/.stack-work/install/x86_64-osx/lts-3.9/7.10.2/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "eco_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "eco_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "eco_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "eco_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "eco_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
