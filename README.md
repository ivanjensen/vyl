vyl
===

Runs 'vi' against one of the results of the last command you ran.

Example usage
=============

Basic case (one result):

<pre>
$ find . -name fred
./fred
$ vyl
----> vi now opens to edit the file ./fred
</pre>

Multiple results:

<pre>
$ find . -name fred
./fred
./src/fred
$ vyl 2
----> vi now opens to edit the file ./src/fred
</pre>

Installation
============

Clone the git repo and then symlink vyl into to a direectory that is on your path

<pre>
git clone https://github.com/ivanjensen/vyl.git ~/Projects/vyl
ln -s ~/Projects/vyl ~/bin
</pre>


License
=======

vyl is release under the MIT license, please see the comments in vyl for the
full license text

Contributing
============

Fork the repo, hack away, send a github pull-request.

What's with the name?
=====================

The name started as 'vil' which was short for 'vi last' as in 'vi' the last result I got. 
But an amusing mistake led to 'vyl', which is pronounced 'vile', which is a nice, but
nasty name :)
