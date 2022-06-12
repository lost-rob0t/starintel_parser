# This is just an example to get you started. A typical hybrid package
# uses this file as the main entry point of the application.

import ./parsing/parsing
import starintel_doc
import cligen
import json
import parsecfg
import options
import asyncdispatch

proc parseJsonFile(path: string, config: MetaConfig, star: AsyncStarintelDatabase) {.async.} =
  let f = open(path)
  defer: f.close
  for line in f.lines:
    star.handleBuffer:
      let x = line.parseJson.parseJsonPerson(config)
      star.cache.people.add(x.person)
      for email in x.emails:
        star.cache.emails.add(email)
      for phone in x.phones:
        star.cache.phones.add(phone)
      for org in x.orgs:
        star.cache.orgs.add(org)
      for membership in x.memberships:
        star.cache.memberships.add(membership)
  await star.clearDocumentBuffer
proc main(host, username, password, database, input: string, port=5984, cacheSize=250, config="config.json") =
  var star = initStarIntel(href=host, database=database, bufferSize=cacheSize)
  waitFor star.login(username, password)
  let x = readConfig(config)
  echo "Processing file: " & input

  waitFor parseJsonFile(input, x, star)

when isMainModule:
  dispatch(main)
