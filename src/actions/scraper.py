"""
A simple scraping script to get all the possible tactics (actions).

NOTE: The documentation does not seem to provide an easy way to figure out
how many arguments a tactic takes, so I think for every tactic we'll put in
a version with a 0, 1, 2, and 3 arguments. Will blow up the action space
a little, but shouldn't be too bad. We can prune later if we want to.
"""

import requests
from bs4 import BeautifulSoup

# Fetch the site
url = "https://coq.inria.fr/refman/coq-tacindex.html"
response = requests.get(url)
assert response.status_code == 200, "Couldn't fetch coq documentation."

# Get the links we care about
soup = BeautifulSoup(response.text, "html.parser")
raw_links = soup.find_all("a", href=True)
codes = [
    raw_link.find_all("code")
    for raw_link in raw_links
    if ("proof-engine/" in raw_link["href"])
    or ("addendum/" in raw_link["href"])
    or ("proofs/" in raw_link["href"])
]

codes = [code[0] for code in codes if len(code) > 0]
tactics = [code.contents for code in codes if "xref" in code["class"]]
tactics = [tactic[0].split("(")[0].strip() for tactic in tactics if len(tactic) == 1]

# Metaprogramming!????!?!!!
fout = open("data.py", "w")

fout.write(
    '''"""
THIS FILE IS AUTO-GENERATED BY `scraper.py`

DO NOT EDIT IT MANUALLY (unless you have good reason ;) )
"""

raw_tactics = [
'''
)

for ix, tactic in enumerate(tactics):
    fout.write(f'    ({ix}, "{tactic}"),\n')

fout.write("]\n")

fout.close()
