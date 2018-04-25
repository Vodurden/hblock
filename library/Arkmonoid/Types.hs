{-# LANGUAGE DataKinds     #-}
{-# LANGUAGE DeriveGeneric #-}

module Arkmonoid.Types where

import           Data.Ecstasy
import qualified Graphics.Gloss.Data.Color as G
import           Linear.V2

import Arkmonoid.Physics.Types

data FollowMouse = FollowMouse Bool Bool -- Follow mouse on the X-axis/Y-axis/both

data Entity' f = Entity
  { entId           :: Component f 'Field Ent
  , physicalObject  :: Component f 'Field PhysicalObject
  , health          :: Component f 'Field Int -- ^ amount of damage this entity can sustain
  , damage          :: Component f 'Field Int -- ^ amount of damage this entity does on collision
  , color           :: Component f 'Field G.Color
  , followMouse     :: Component f 'Field FollowMouse
  , debug           :: Component f 'Field ()
  }
  deriving (Generic)

type World = (Int, Entity' 'WorldOf)
type GameSystem a = System Entity' a

type GameQueryT m a = QueryT Entity' m a

-- Todo find a better way to expose these globals
screenWidth = 640
screenHeight = 480