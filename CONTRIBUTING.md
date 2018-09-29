## New Features/Fixes
For any new feature create a new branch and a mr. It is
important that the branch is created from this project and
not from a fork because if not the selenium pipeline would fail.

## Commits
Pleas consider to write good commit messages (with body).

## Patterns
Pleas consider to follow the listed patterns in the indicated order:
- Single responsibility: E.g. validations in the form objects.
- Tell don't ask.
- Law of Demeter.

## Functional programming
Also take in consideration that we are in favor of mixing functional
programming with OOP. For this we use Trailblazers Transaccions.

## DRY
We try to make the code DRY. This do not mean that some code can
not be duplicated for a short period of time. Sometimes, it make
necessary to have some duplications to recolect enough information
to create an apporpiate DRY solution.

## Docker
We strongly recoment to use docker for your development enviroment but we
will not force yout to use it. What we can not garanzize that all works out
of the box without docker. Of curse, if you found any problem to run it
withut docker, you can submit an issue.
