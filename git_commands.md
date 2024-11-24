- "init": initializes a new repo
"git init"

- "clone": copies an existing repo on your local machine
"git clone https://github.com/SkillpTm/Caasi"

- "add": stages the changes, but they don't get commited
"git add Player.gd"

- "commit": commits the staged changes to git
"git commit -m "changed something""

- "push": pushes the file to github
"git push origin master" --> master=branch

    if there is no branch on Github for your current local branch do:
    "git push -u origin some-feature-branch"

- "pull": downloads changes to the repo
"git pull origin master" --> master=branch

- "branch": shows all branches, the one with an * you're on
"git branch"

    to delete a branch do:
    "git branch -d some-feature-branch"

- "checkout": allows you to change and create branches
"git checkout some-feature-branch"
"git checkout -b your-new-feature-branch"

- "mv": allows you to change the postion or rename a file
"git mv .\Player\Player.gd .\Scene\Player.gd"
"git mv .\Player\Player.gd .\Player\player.gd"

- "status": shows you your current file changes compared to your last commit
"git status"

- "diff": compares your current branch to whatever branch you input
"git diff master"

- "merge": merges two branches, the branch you select will be merged into your current branch (we'll only merge master into our branches and pr branches into master)
"git merge master"

- "reset": unstages files or reverts commits (The changes remain, just aren't commited anymore)
"git reset .\Player\Player.gd"
"git reset HEAD~1" (unstages AND uncommits last commit)

    if you want to REMOVE your changes while reseting use this command
    "git reset --hard HEAD~1"

- "log": see the commit log
"git log" (you can use an hash to git reset)

Motto: many small commit rather than some big ones