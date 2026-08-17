namespace GameNight

def canJoin (hasConfirmed isInvited : Bool) : Bool :=
  hasConfirmed && isInvited

def bringsSnacks (isHost volunteered : Bool) : Bool :=
  isHost || volunteered

def isSkipping (isComing : Bool) : Bool :=
  !isComing

def votedSame (firstVote secondVote : Bool) : Bool :=
  firstVote == secondVote

def hasScorekeeper (aVolunteers bVolunteers : Bool) : Bool :=
  aVolunteers ^^ bVolunteers

end GameNight
