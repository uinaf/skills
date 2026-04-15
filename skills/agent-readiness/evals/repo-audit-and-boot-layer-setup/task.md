# Getting a Legacy Node.js API Ready for Autonomous Development

## Problem/Feature Description

Your team has inherited a Node.js REST API from a contractor. The codebase lives in a git repository but nobody on the team has run it locally — the original developer left only a vague README saying "run npm start." There's no reliable way to know if the app is alive after starting it, no health endpoint, and CI has been broken for weeks. The engineering manager wants agents to start working on features autonomously, but right now no agent can tell whether its changes broke anything.

Your job is to assess the current state of the repo and add the minimum infrastructure needed for an agent to reliably start the app and verify it's alive. Produce a written audit report and an `init.sh` script that boots the app and confirms it is up.

## Output Specification

Produce the following files:

1. `audit-report.md` — A written assessment of the repository's current state from an autonomous-agent perspective. Evaluate the repo across multiple aspects of agent-readiness. For each aspect, indicate how well it is covered, cite specific evidence (a file path or runnable command), and describe what is missing. Include an overall summary grade.

2. `scripts/init.sh` — A shell script that starts the application and verifies it is ready to receive traffic before returning. The script must exit with a non-zero status code if the app fails to come up.

3. `improvements.md` — A short explanation of which readiness layers you addressed, which remain missing, and what the recommended next steps are.

## Input Files

The following files represent the inherited repository. Extract them before beginning.

=============== FILE: app/package.json ===============
{
  "name": "legacy-inventory-api",
  "version": "1.0.0",
  "description": "Inventory management REST API",
  "main": "src/index.js",
  "scripts": {
    "start": "node src/index.js",
    "test": "jest"
  },
  "dependencies": {
    "express": "^4.18.2"
  },
  "devDependencies": {
    "jest": "^29.0.0"
  }
}

=============== FILE: app/src/index.js ===============
const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());

const items = [];

app.get('/items', (req, res) => {
  res.json(items);
});

app.post('/items', (req, res) => {
  const item = { id: Date.now(), ...req.body };
  items.push(item);
  res.status(201).json(item);
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});

=============== FILE: app/test/items.test.js ===============
const { createItem, getItems } = require('../src/items');

jest.mock('../src/items');

test('createItem returns an object', () => {
  createItem.mockReturnValue({ id: 1, name: 'test' });
  const result = createItem({ name: 'test' });
  expect(result).toEqual({ id: 1, name: 'test' });
});

test('getItems returns array', () => {
  getItems.mockReturnValue([]);
  expect(getItems()).toEqual([]);
});

=============== FILE: app/README.md ===============
# Inventory API

Run `npm start` to start the server.
