module Paths_shakespear (
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

bindir     = "/Users/eric/Desktop/test/apresentacao/4-shakespear/.stack-work/install/x86_64-osx/lts-3.9/7.10.2/bin"
libdir     = "/Users/eric/Desktop/test/apresentacao/4-shakespear/.stack-work/install/x86_64-osx/lts-3.9/7.10.2/lib/x86_64-osx-ghc-7.10.2/shakespear-0.0.0-Kr4Zv3MxKRmJUiAGecckQ4"
datadir    = "/Users/eric/Desktop/test/apresentacao/4-shakespear/.stack-work/install/x86_64-osx/lts-3.9/7.10.2/share/x86_64-osx-ghc-7.10.2/shakespear-0.0.0"
libexecdir = "/Users/eric/Desktop/test/apresentacao/4-shakespear/.stack-work/install/x86_64-osx/lts-3.9/7.10.2/libexec"
sysconfdir = "/Users/eric/Desktop/test/apresentacao/4-shakespear/.stack-work/install/x86_64-osx/lts-3.9/7.10.2/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "shakespear_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "shakespear_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "shakespear_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "shakespear_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "shakespear_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
