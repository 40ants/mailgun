=========================================
 mailgun - send emails from Common Lisp!
=========================================

.. Everything starting from this commit will be inserted into the
   index page of the HTML documentation.
.. include-from

This library provides an easy way to send transactional emails through
http://mailgun.com.

.. note:: You don't have to setup your own SMTP servers!

          And they have a "free" plan with 10000 emails per month.


Reasoning
=========

Previously, I used this code in one of my projects, but seems this
functionality needed almost in any serious web application. So, I
decided to make it available as a separate library.

Here is how to use it
=====================

First, setup an account at http://mailgun.com. You need to add your
domain there and to reveive an authentication token.

.. code-block:: common-lisp

   (setf mailgun:*domain* "mail.skazorama.ru")
   (setf mailgun:*api-key* "key-************************")

   (mailgun:send ("noreply@skazorama.ru"
                  "svetlyak.40wt@gmail.com"
                  "Mail subject")
     (:h1 "This is a test letter")
     (:p "It is in a HTML format and supports some tags"
         "For example, I can make " (:b "a bold text") ".")
     (:p "And here we have some items, passed to the template:")
     (:ul
      (loop for item in items
            do (mailgun:htm
                (:li item)))))

.. Everything after this comment will be omitted from HTML docs.
.. include-to

Building Documentation
======================

Provide instruction how to build or use your library.

How to build documentation
--------------------------

To build documentation, you need a Sphinx. It is
documentaion building tool written in Python.

To install it, you need a virtualenv. Read
this instructions
`how to install it
<https://virtualenv.pypa.io/en/stable/installation/#installation>`_.

Also, you'll need a `cl-launch <http://www.cliki.net/CL-Launch>`_.
It is used by documentation tool to run a script which extracts
documentation strings from lisp systems.

Run these commands to build documentation::

  virtualenv env
  source env/bin/activate
  pip install -r docs/requirements.txt
  invoke build_docs

These commands will create a virtual environment and
install some python libraries there. Command ``invoke build_docs``
will build documentation and upload it to the GitHub, by replacing
the content of the ``gh-pages`` branch.


Authors
=======

* Alexander Artemenko (svetlyak.40wt@gmail.com)

Copyright
=========

Copyright (c) 2018 Alexander Artemenko (svetlyak.40wt@gmail.com)
