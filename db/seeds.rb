Ctf.create(name: "ctf no. 1")
Ctf.create(name: "ctf no. 2")
Ctf.create(name: "ctf no. 3")

Team.create(name: "team 1")
Team.create(name: "team 2")
Team.create(name: "team 3")

User.create(username: "user1", password: "psw1", salt: "salt1")
User.create(username: "user2", password: "psw2", salt: "salt2")
User.create(username: "user3", password: "psw3", salt: "salt3")

TeamUser.create(user_id: 1, team_id: 1, as_admin: false)
TeamUser.create(user_id: 2, team_id: 1, as_admin: true)
TeamUser.create(user_id: 2, team_id: 2, as_admin: false)
TeamUser.create(user_id: 1, team_id: 2, as_admin: true)
TeamUser.create(user_id: 1, team_id: 0xdeadbeef, as_admin: false) #non viene aggiunto, viola fkey

Chal.create(ctf_id: 1, name: "crypto100")
Chal.create(ctf_id: 1, name: "crypto200")
Chal.create(ctf_id: 1, name: "crypto300")
Chal.create(ctf_id: 2, name: "crypto400")
Chal.create(ctf_id: 2, name: "crypto500")
Chal.create(ctf_id: 2, name: "crypto600")

Partecipate.create(ctf_id: 1, team_id: 1)
Partecipate.create(ctf_id: 1, team_id: 2)
Partecipate.create(ctf_id: 2, team_id: 1)
Partecipate.create(ctf_id: 2, team_id: 2)
Partecipate.create(ctf_id: 2, team_id: 3)

Solve.create(chal_id: 1, user_id: 1, team_id: 1)
Solve.create(chal_id: 2, user_id: 1, team_id: 1)


#todo: - in solve (user_id, team_id) in TeamUser
#      - 
