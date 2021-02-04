{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_leetcode (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/nathan/.cabal/bin"
libdir     = "/home/nathan/.cabal/lib/x86_64-linux-ghc-8.8.4/leetcode-0.1.0.0-inplace-leetcode"
dynlibdir  = "/home/nathan/.cabal/lib/x86_64-linux-ghc-8.8.4"
datadir    = "/home/nathan/.cabal/share/x86_64-linux-ghc-8.8.4/leetcode-0.1.0.0"
libexecdir = "/home/nathan/.cabal/libexec/x86_64-linux-ghc-8.8.4/leetcode-0.1.0.0"
sysconfdir = "/home/nathan/.cabal/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "leetcode_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "leetcode_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "leetcode_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "leetcode_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "leetcode_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "leetcode_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
