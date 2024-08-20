import {Octokit} from '@octokit/core';
import {paginateRest} from '@octokit/plugin-paginate-rest';

const MyOctokit = Octokit.plugin(paginateRest);

const octokit = new MyOctokit({
  auth: process.env.GITHUB_TOKEN,
});

const owner = process.argv[2];
const repo = process.argv[3];
const workflow_id = process.argv[4];
console.log(`GET /repos/${owner}/${repo}/actions/workflows/${workflow_id}/runs`);
const result = await octokit.paginate('GET /repos/{owner}/{repo}/actions/workflows/{workflow_id}/runs', {
  owner,
  repo,
  workflow_id,
  per_page: 100,
});

const grouped = {};

for (const run of result) {
  let login = run.actor.login;
  grouped[login] ||= {attempts: 0, runs: 0};
  grouped[login].attempts += run.run_attempt > 1 ? 1 : 0;
  grouped[login].runs++;
}

console.log(grouped);
