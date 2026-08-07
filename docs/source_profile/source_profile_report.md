# Source Data Profile Report

Generated: 2026-08-07T14:24:33.544750Z

## Priority files

- ✅ `patients.csv`
- ✅ `encounters.csv`
- ✅ `conditions.csv`
- ✅ `procedures.csv`
- ✅ `claims.csv`
- ✅ `claims_transactions.csv`
- ✅ `providers.csv`
- ✅ `payers.csv`

## Table summaries

### claims.csv

- Rows: 9995
- Columns: 31
- Duplicate rows: 0
- Candidate primary keys: Id
- Likely ID-like columns: Id, PATIENTID, PROVIDERID, PRIMARYPATIENTINSURANCEID, SECONDARYPATIENTINSURANCEID, DEPARTMENTID, PATIENTDEPARTMENTID, REFERRINGPROVIDERID, APPOINTMENTID, SUPERVISINGPROVIDERID, HEALTHCARECLAIMTYPEID1, HEALTHCARECLAIMTYPEID2
- Likely foreign-key hints: APPOINTMENTID, DEPARTMENTID, Id, PATIENTID, PROVIDERID, SUPERVISINGPROVIDERID

| Column | Pandas dtype | Inferred type | Null % | Unique % | Sample values | Min | Max | Mean |
|---|---|---|---|---|---|---|---|---|
| `Id` | str | string | 0.00% | 100.00% | f9ba83f7-9940-16ae-aea2-f332500346b3; a1733070-046a-4506-14ba-2d05e1f4f5be; f9ba83f7-9940-16ae-352d-99daf1290043; f9ba83f7-9940-16ae-1f4a-2ead388057a6; a1733070-046a-4506-efe8-a04578e36420 | None | None | None |
| `PATIENTID` | str | string | 0.00% | 1.08% | 7ad140ab-bfae-c3ae-20a3-2244b1c4d0e2; 688c8453-ba6f-7dec-03c3-eaa27d6df1a4; 5d84e6a3-b4bd-63d6-57c5-cada0916490d; 01a006ce-6457-50c2-8e0a-fb58fc310a86; 53e4891a-9108-67ef-d973-3b6a98404249 | None | None | None |
| `PROVIDERID` | str | string | 0.00% | 2.41% | 8271f04c-c469-3138-90e5-1ccaad83e76a; 8bc8b7c1-5bf3-33fc-9ae4-95c36ef6066b; cc295ab5-8573-34d4-8c3e-4939419ac991; f5ec1762-f97e-3401-83e7-c78aac389abb; 2a49ddca-825c-3639-b867-24d56673e852 | None | None | None |
| `PRIMARYPATIENTINSURANCEID` | str | string | 6.63% | 0.09% | a735bf55-83e9-331a-899d-a82a60b9f60c; 26aab0cd-6aba-3e1b-ac5b-05c8867e762c; d18ef2e6-ef40-324c-be54-34a5ee865625; df166300-5a78-3502-a46a-832842197811; d31fccc3-1767-390d-966a-22a5156f4219 | None | None | None |
| `SECONDARYPATIENTINSURANCEID` | str | string | 71.18% | 0.01% | b046940f-1664-3047-bca7-dfa76be352a4 | None | None | None |
| `DEPARTMENTID` | int64 | integer | 0.00% | 0.11% | 1; 20; 2; 5; 10 | 1 | 20 | 5.7893946973486745 |
| `PATIENTDEPARTMENTID` | int64 | integer | 0.00% | 0.11% | 1; 20; 2; 5; 10 | 1 | 20 | 5.7893946973486745 |
| `DIAGNOSIS1` | int64 | integer | 0.00% | 1.57% | 314529007; 431857002; 66383009; 103697008; 160903007 | 3718001 | 10939881000119105 | 14441628904193.588 |
| `DIAGNOSIS2` | float64 | float | 67.05% | 1.24% | 73595000.0; 160903007.0; 160904001.0; 66383009.0; 423315002.0 | 6525002.0 | 1.0939881000119104e+16 | 74088095549363.64 |
| `DIAGNOSIS3` | float64 | float | 88.72% | 0.68% | 66383009.0; 73595000.0; 422650009.0; 423315002.0; 706893006.0 | 11625007.0 | 1.0939881000119104e+16 | 214581340772998.44 |
| `DIAGNOSIS4` | float64 | float | 96.75% | 0.32% | 66383009.0; 271825005.0; 73595000.0; 424393004.0; 706893006.0 | 35999006.0 | 1.0939881000119104e+16 | 370331744953992.75 |
| `DIAGNOSIS5` | float64 | float | 99.09% | 0.13% | 65710008.0; 66383009.0; 361055000.0; 160904001.0; 73595000.0 | 36955009.0 | 368581000119106.0 | 4050490954634.099 |
| `DIAGNOSIS6` | float64 | float | 99.65% | 0.06% | 770349000.0; 73595000.0; 840539006.0; 66383009.0; 267036007.0 | 66383009.0 | 840539006.0 | 562367858.4 |
| `DIAGNOSIS7` | float64 | float | 99.71% | 0.05% | 706870000.0; 66383009.0; 56018004.0; 57676002.0; 706893006.0 | 56018004.0 | 706893006.0 | 551612829.5517242 |
| `DIAGNOSIS8` | float64 | float | 99.98% | 0.02% | 68962001.0; 36955009.0 | 36955009.0 | 68962001.0 | 52958505.0 |
| `REFERRINGPROVIDERID` | float64 | float | 100.00% | 0.00% |  | None | None | None |
| `APPOINTMENTID` | str | string | 0.00% | 54.76% | a03e9688-2e96-60c9-0893-f74323681cc5; c1e9a9fb-45ec-4ee4-9822-a6f130ce95c1; 688c8453-ba6f-7dec-e599-574ee491e288; 885c1eeb-1b4c-8a3a-ad24-1e156a22d3c5; 688c8453-ba6f-7dec-28a3-5435453dee59 | None | None | None |
| `CURRENTILLNESSDATE` | str | datetime | 0.00% | 48.64% | 2004-11-30T21:16:46Z; 2003-12-30T09:32:32Z; 2002-02-06T17:55:45Z; 1995-05-08T07:03:05Z; 2006-07-24T07:01:15Z | 1952-10-22 23:17:16+00:00 | 2026-07-14 12:16:32+00:00 | None |
| `SERVICEDATE` | str | datetime | 0.00% | 53.92% | 2021-05-06T01:26:20Z; 2021-01-02T16:04:56Z; 2017-03-10T11:40:07Z; 2023-05-19T12:15:20Z; 2020-06-15T07:01:15Z | 1952-10-22 23:17:16+00:00 | 2026-07-15 01:29:39+00:00 | None |
| `SUPERVISINGPROVIDERID` | str | string | 0.00% | 2.41% | 8271f04c-c469-3138-90e5-1ccaad83e76a; 8bc8b7c1-5bf3-33fc-9ae4-95c36ef6066b; cc295ab5-8573-34d4-8c3e-4939419ac991; f5ec1762-f97e-3401-83e7-c78aac389abb; 2a49ddca-825c-3639-b867-24d56673e852 | None | None | None |
| `STATUS1` | str | string | 0.00% | 0.02% | CLOSED; BILLED | None | None | None |
| `STATUS2` | str | string | 28.82% | 0.02% | CLOSED; BILLED | None | None | None |
| `STATUSP` | str | string | 0.00% | 0.02% | CLOSED; BILLED | None | None | None |
| `OUTSTANDING1` | float64 | float | 0.00% | 0.05% | 0.0; 169.1; 8896.74; 211.38; 94.15 | 0.0 | 8896.74 | 1.00527963981991 |
| `OUTSTANDING2` | float64 | float | 28.82% | 0.03% | 0.0; 211.38; 94.15 | 0.0 | 211.38 | 0.04294770874332302 |
| `OUTSTANDINGP` | float64 | float | 0.00% | 0.05% | 0.0; 42.28; 211.38; 2457.19; 117.23 | 0.0 | 2457.19 | 0.3210185092546273 |
| `LASTBILLEDDATE1` | str | datetime | 0.00% | 54.69% | 2021-05-15T02:25:04Z; 2021-01-11T22:10:39Z; 2017-03-26T00:54:30Z; 2023-05-20T15:19:02Z; 2015-08-12T14:16:01Z | 1952-10-24 02:16:34+00:00 | 2026-07-15 06:00:17+00:00 | None |
| `LASTBILLEDDATE2` | str | datetime | 28.82% | 40.96% | 2021-05-15T02:25:04Z; 2021-01-11T22:10:39Z; 2025-07-14T00:52:10Z; 2021-01-17T07:08:32Z; 2017-12-07T09:15:36Z | 1952-10-24 02:16:34+00:00 | 2026-07-15 06:00:17+00:00 | None |
| `LASTBILLEDDATEP` | str | datetime | 0.00% | 54.69% | 2021-05-15T02:25:04Z; 2021-01-11T22:10:39Z; 2017-03-26T00:54:30Z; 2023-05-20T15:19:02Z; 2015-08-12T14:16:01Z | 1952-10-24 02:16:34+00:00 | 2026-07-15 06:00:17+00:00 | None |
| `HEALTHCARECLAIMTYPEID1` | int64 | integer | 0.00% | 0.02% | 2; 1 | 1 | 2 | 1.5168584292146072 |
| `HEALTHCARECLAIMTYPEID2` | int64 | integer | 0.00% | 0.03% | 2; 0; 1 | 0 | 2 | 1.1404702351175589 |

### claims_transactions.csv

- Rows: 91071
- Columns: 33
- Duplicate rows: 0
- Candidate primary keys: ID, CHARGEID
- Likely ID-like columns: ID, CLAIMID, CHARGEID, PATIENTID, PROCEDURECODE, DEPARTMENTID, TRANSFEROUTID, APPOINTMENTID, PATIENTINSURANCEID, FEESCHEDULEID, PROVIDERID, SUPERVISINGPROVIDERID
- Likely foreign-key hints: APPOINTMENTID, DEPARTMENTID, ID, PATIENTID, PROVIDERID, SUPERVISINGPROVIDERID

| Column | Pandas dtype | Inferred type | Null % | Unique % | Sample values | Min | Max | Mean |
|---|---|---|---|---|---|---|---|---|
| `ID` | str | string | 0.00% | 100.00% | 938b6627-f7ab-bf62-d3ef-bde9e8efae59; de2d989f-deae-fd8a-dfbe-f7a7a3beb967; efc60d69-095f-2885-bd85-b094daf93399; f1811d7f-23c7-e18a-6b51-369514457388; c62275fc-8f1f-862b-ad62-da545115ce21 | None | None | None |
| `CLAIMID` | str | string | 0.00% | 10.97% | 93904045-6509-c7c6-6a6e-a9d8e7bd0765; 531968a3-50fe-09ba-bd4f-6db4b6c728d0; ba234ff2-cefe-dfee-b5b9-6cb7a9be1860; 2eb14889-46f2-06de-cb31-2b0ba295da73; 03a7cc66-36c5-356c-5ab4-fcc0ffcab9e8 | None | None | None |
| `CHARGEID` | int64 | integer | 0.00% | 100.00% | 0; 2; 1; 4; 6 | 0 | 118780 | 59489.20426919656 |
| `PATIENTID` | str | string | 0.00% | 0.12% | 688c8453-ba6f-7dec-03c3-eaa27d6df1a4; 7ad140ab-bfae-c3ae-20a3-2244b1c4d0e2; 5d84e6a3-b4bd-63d6-57c5-cada0916490d; 01a006ce-6457-50c2-8e0a-fb58fc310a86; 53e4891a-9108-67ef-d973-3b6a98404249 | None | None | None |
| `TYPE` | str | string | 0.00% | 0.00% | PAYMENT; CHARGE; TRANSFEROUT; TRANSFERIN | None | None | None |
| `AMOUNT` | float64 | float | 53.53% | 4.26% | 431.4; 0.0; 86.28; 85.55; 136.0 | 0.0 | 91039.8 | 378.1677711355796 |
| `METHOD` | str | string | 62.51% | 0.01% | ECHECK; CC; CASH; CHECK; COPAY | None | None | None |
| `FROMDATE` | str | datetime | 0.00% | 17.29% | 2019-11-09T12:23:02Z; 2019-06-25T05:35:43Z; 2022-07-13T15:42:32Z; 2017-01-31T00:08:48Z; 2023-04-29T02:37:30Z | 1952-10-22 23:17:16+00:00 | 2026-07-15 05:51:05+00:00 | None |
| `TODATE` | str | datetime | 0.00% | 19.54% | 1970-01-01T00:00:00Z; 2019-06-25T05:50:43Z; 2022-07-13T15:57:32Z; 2017-01-31T00:23:48Z; 2023-04-29T02:52:30Z | 1952-10-24 02:16:34+00:00 | 2026-07-15 06:00:17+00:00 | None |
| `PLACEOFSERVICE` | str | string | 0.00% | 0.26% | 9ed61c49-1d0c-3774-b528-d75b50938fe2; 9adfae03-673d-365d-9052-f705098fa3e4; 2836d9ac-c6a6-39d1-8f13-fdf0fc8928f4; ce4d0501-49eb-396a-bc56-545fdfc624b0; dae3ee01-f383-366e-9ad6-dc92963064ea | None | None | None |
| `PROCEDURECODE` | int64 | integer | 0.00% | 0.49% | 185347001; 185349003; 710824005; 162673000; 140 | 3 | 456191000124101 | 5358786819201.552 |
| `MODIFIER1` | float64 | float | 100.00% | 0.00% |  | None | None | None |
| `MODIFIER2` | float64 | float | 100.00% | 0.00% |  | None | None | None |
| `DIAGNOSISREF1` | int64 | integer | 0.00% | 0.00% | 1 | 1 | 1 | 1.0 |
| `DIAGNOSISREF2` | float64 | float | 64.72% | 0.00% | 2.0 | 2.0 | 2.0 | 2.0 |
| `DIAGNOSISREF3` | float64 | float | 88.73% | 0.00% | 3.0 | 3.0 | 3.0 | 3.0 |
| `DIAGNOSISREF4` | float64 | float | 97.22% | 0.00% | 4.0 | 4.0 | 4.0 | 4.0 |
| `UNITS` | int64 | integer | 0.00% | 0.00% | 1 | 1 | 1 | 1.0 |
| `DEPARTMENTID` | int64 | integer | 0.00% | 0.01% | 1; 20; 2; 10; 5 | 1 | 20 | 5.704318608558158 |
| `NOTES` | str | string | 0.00% | 0.49% | Encounter for problem (procedure); Encounter for check up (procedure); Assessment of health and social care needs (procedure); General examination of patient (procedure); Influenza  split virus  trivalent  PF | None | None | None |
| `UNITAMOUNT` | float64 | float | 0.00% | 2.83% | 0.0; 431.4; 85.55; 136.0; 136.8 | 0.0 | 91039.8 | 144.99752511776526 |
| `TRANSFEROUTID` | float64 | float | 83.96% | 16.04% | 8.0; 16.0; 39.0; 46.0; 56.0 | 8.0 | 118778.0 | 62092.87673670522 |
| `TRANSFERTYPE` | str | string | 53.53% | 0.00% | 1; p; 2 | None | None | None |
| `PAYMENTS` | float64 | float | 0.00% | 4.64% | 0.0; 431.4; 345.12; 86.28; 136.0 | 0.0 | 72831.84 | 144.99752511776526 |
| `ADJUSTMENTS` | float64 | float | 0.00% | 0.00% | 0.0 | 0.0 | 0.0 | 0.0 |
| `TRANSFERS` | float64 | float | 67.91% | 1.93% | 86.28; 431.4; 17.11; 136.0; 136.8 | 0.01 | 18207.96 | 191.6191088905619 |
| `OUTSTANDING` | float64 | float | 0.00% | 2.07% | 0.0; 86.28; 17.11; 431.4; 136.0 | 0.0 | 18207.96 | 80.48504617276629 |
| `APPOINTMENTID` | str | string | 0.00% | 6.01% | 93904045-6509-c7c6-db98-e69defd24afa; 531968a3-50fe-09ba-4b61-fa85fbd4713a; ba234ff2-cefe-dfee-16de-c1ae0438d3a0; 2eb14889-46f2-06de-5302-829eada1915e; 03a7cc66-36c5-356c-56a5-3b892a952568 | None | None | None |
| `LINENOTE` | float64 | float | 100.00% | 0.00% |  | None | None | None |
| `PATIENTINSURANCEID` | str | string | 3.86% | 1.19% | 688c8453-ba6f-7dec-2225-0c3fecf6a92f; 688c8453-ba6f-7dec-9950-dfd61dde7cdf; 688c8453-ba6f-7dec-64a2-996937b9d8f1; 688c8453-ba6f-7dec-5dd4-da2e9941adce; 688c8453-ba6f-7dec-4508-ef4a9b834994 | None | None | None |
| `FEESCHEDULEID` | int64 | integer | 0.00% | 0.00% | 1 | 1 | 1 | 1.0 |
| `PROVIDERID` | str | string | 0.00% | 0.26% | 8271f04c-c469-3138-90e5-1ccaad83e76a; 8bc8b7c1-5bf3-33fc-9ae4-95c36ef6066b; 3e979fd9-4b62-3544-9ba8-5ed03b508c7b; cc295ab5-8573-34d4-8c3e-4939419ac991; 451f1877-9e4a-37c8-852e-42318721bbc4 | None | None | None |
| `SUPERVISINGPROVIDERID` | str | string | 0.00% | 0.26% | 8271f04c-c469-3138-90e5-1ccaad83e76a; 8bc8b7c1-5bf3-33fc-9ae4-95c36ef6066b; 3e979fd9-4b62-3544-9ba8-5ed03b508c7b; cc295ab5-8573-34d4-8c3e-4939419ac991; 451f1877-9e4a-37c8-852e-42318721bbc4 | None | None | None |

### conditions.csv

- Rows: 3784
- Columns: 7
- Duplicate rows: 0
- Candidate primary keys: None
- Likely ID-like columns: CODE
- Likely foreign-key hints: CODE

| Column | Pandas dtype | Inferred type | Null % | Unique % | Sample values | Min | Max | Mean |
|---|---|---|---|---|---|---|---|---|
| `START` | str | datetime | 0.00% | 54.76% | 2014-02-06; 2014-02-05; 2021-05-06; 2014-02-01; 2021-01-09 | 1952-10-22 00:00:00 | 2026-07-15 00:00:00 | None |
| `STOP` | str | datetime | 25.53% | 41.91% | 2021-05-15; 2021-01-26; 2023-12-30; 2020-06-01; 2018-06-18 | 2004-12-31 00:00:00 | 2026-07-12 00:00:00 | None |
| `PATIENT` | str | string | 0.00% | 2.85% | 5d84e6a3-b4bd-63d6-57c5-cada0916490d; 7ad140ab-bfae-c3ae-20a3-2244b1c4d0e2; 688c8453-ba6f-7dec-03c3-eaa27d6df1a4; 01a006ce-6457-50c2-8e0a-fb58fc310a86; 8d7f6a31-31ba-da9c-2b57-03ee0f7577a0 | None | None | None |
| `ENCOUNTER` | str | string | 0.00% | 64.59% | ba234ff2-cefe-dfee-c9c3-9a33b5eef6a1; a03e9688-2e96-60c9-b99c-da2189cf3e3b; d3bcf7cc-11ff-2e5c-b358-5db3a9779d91; e27ebe5d-6514-4fb0-18c3-0605484f9868; 4856d816-b2ac-e1b6-369f-59903b6edc4b | None | None | None |
| `SYSTEM` | str | string | 0.00% | 0.03% | http://snomed.info/sct | None | None | None |
| `CODE` | int64 | integer | 0.00% | 4.76% | 314529007; 73595000; 160903007; 66383009; 160904001 | 6525002 | 10939881000119105 | 64439819873442.38 |
| `DESCRIPTION` | str | string | 0.00% | 4.76% | Medication review due (situation); Stress (finding); Full-time employment (finding); Gingivitis (disorder); Part-time employment (finding) | None | None | None |

### encounters.csv

- Rows: 5473
- Columns: 15
- Duplicate rows: 0
- Candidate primary keys: Id
- Likely ID-like columns: Id, PROVIDER, CODE, REASONCODE
- Likely foreign-key hints: CODE, Id, REASONCODE

| Column | Pandas dtype | Inferred type | Null % | Unique % | Sample values | Min | Max | Mean |
|---|---|---|---|---|---|---|---|---|
| `Id` | str | string | 0.00% | 100.00% | f9ba83f7-9940-16ae-5f88-aea1af242f71; a1733070-046a-4506-13b1-f518d757cdd0; f9ba83f7-9940-16ae-81d1-8cdb486ca3ad; f9ba83f7-9940-16ae-158c-5cd0e5a140b9; a1733070-046a-4506-0d73-cf2822965f28 | None | None | None |
| `START` | str | datetime | 0.00% | 98.47% | 2017-09-19T05:35:43Z; 2017-10-31T05:35:43Z; 2017-11-07T05:35:43Z; 2021-05-04T05:35:43Z; 2019-09-11T12:07:50Z | 1952-10-22 23:17:16+00:00 | 2026-07-15 01:29:39+00:00 | None |
| `STOP` | str | datetime | 0.00% | 99.87% | 2017-10-31T05:50:43Z; 2017-11-07T05:50:43Z; 2021-05-04T05:50:43Z; 2019-11-18T07:16:15Z; 2021-05-30T05:13:52Z | 1952-10-24 02:16:34+00:00 | 2026-07-15 06:00:17+00:00 | None |
| `PATIENT` | str | string | 0.00% | 1.97% | 688c8453-ba6f-7dec-03c3-eaa27d6df1a4; 7ad140ab-bfae-c3ae-20a3-2244b1c4d0e2; 5d84e6a3-b4bd-63d6-57c5-cada0916490d; 21060120-8398-1940-3dc7-1d7f56bb2674; 8d7f6a31-31ba-da9c-2b57-03ee0f7577a0 | None | None | None |
| `ORGANIZATION` | str | string | 0.00% | 4.40% | 9ed61c49-1d0c-3774-b528-d75b50938fe2; 9adfae03-673d-365d-9052-f705098fa3e4; ce4d0501-49eb-396a-bc56-545fdfc624b0; 2836d9ac-c6a6-39d1-8f13-fdf0fc8928f4; 0d9b0d22-585e-3fd8-ab02-26b5be7915d1 | None | None | None |
| `PROVIDER` | str | string | 0.00% | 4.40% | 8271f04c-c469-3138-90e5-1ccaad83e76a; 8bc8b7c1-5bf3-33fc-9ae4-95c36ef6066b; cc295ab5-8573-34d4-8c3e-4939419ac991; 3e979fd9-4b62-3544-9ba8-5ed03b508c7b; aad125bd-437a-36ce-8c15-7dcd97531abd | None | None | None |
| `PAYER` | str | string | 0.00% | 0.18% | a735bf55-83e9-331a-899d-a82a60b9f60c; 26aab0cd-6aba-3e1b-ac5b-05c8867e762c; d18ef2e6-ef40-324c-be54-34a5ee865625; df166300-5a78-3502-a46a-832842197811; d31fccc3-1767-390d-966a-22a5156f4219 | None | None | None |
| `ENCOUNTERCLASS` | str | string | 0.00% | 0.18% | ambulatory; wellness; outpatient; urgentcare; emergency | None | None | None |
| `CODE` | int64 | integer | 0.00% | 0.80% | 185347001; 185349003; 162673000; 410620009; 185345009 | 1505002 | 702927004 | 255363070.50137037 |
| `DESCRIPTION` | str | string | 0.00% | 0.80% | Encounter for problem (procedure); Encounter for check up (procedure); General examination of patient (procedure); Well child visit (procedure); Encounter for symptom (procedure) | None | None | None |
| `BASE_ENCOUNTER_COST` | float64 | float | 0.00% | 0.18% | 85.55; 136.8; 142.58; 146.18; 128.53 | 75.0 | 146.18 | 114.35495340763748 |
| `TOTAL_CLAIM_COST` | float64 | float | 0.00% | 30.95% | 85.55; 535.87; 3105.35; 234.71; 516.95 | 75.0 | 92048.78 | 2555.03573908277 |
| `PAYER_COVERAGE` | float64 | float | 0.00% | 34.70% | 0.0; 428.7; 68.44; 187.76; 500.87 | 0.0 | 78473.63 | 1797.7920847798282 |
| `REASONCODE` | float64 | float | 42.96% | 1.94% | 431857002.0; 72892002.0; 103697008.0; 66383009.0; 389095005.0 | 3718001.0 | 442571000124108.0 | 481782727786.9359 |
| `REASONDESCRIPTION` | str | string | 42.96% | 1.94% | Chronic kidney disease stage 4 (disorder); Normal pregnancy (finding); Patient referral for dental care (procedure); Gingivitis (disorder); Contraception care (regime/therapy) | None | None | None |

### patients.csv

- Rows: 108
- Columns: 28
- Duplicate rows: 0
- Candidate primary keys: Id, SSN, ADDRESS, LAT, LON, HEALTHCARE_EXPENSES
- Likely ID-like columns: Id, MIDDLE, MAIDEN
- Likely foreign-key hints: Id

| Column | Pandas dtype | Inferred type | Null % | Unique % | Sample values | Min | Max | Mean |
|---|---|---|---|---|---|---|---|---|
| `Id` | str | string | 0.00% | 100.00% | a1733070-046a-4506-bba6-47f32652e9d7; f9ba83f7-9940-16ae-0854-24bd34bf1843; fc2d1fb9-862d-a60c-581a-519f5470d866; 5a1b2463-6dbf-ff69-4ab9-fbc24841b9fd; 50834d5b-3074-9f8b-833e-e32a1004126d | None | None | None |
| `BIRTHDATE` | str | datetime | 0.00% | 91.67% | 2005-10-30; 1954-04-26; 1959-02-13; 1960-03-14; 1942-02-07 | 1942-02-07 00:00:00 | 2025-08-21 00:00:00 | None |
| `DEATHDATE` | str | datetime | 91.67% | 8.33% | 2008-03-09; 2024-04-06; 2019-07-20; 2014-10-23; 2016-12-18 | 2008-03-09 00:00:00 | 2025-09-25 00:00:00 | None |
| `SSN` | str | string | 0.00% | 100.00% | 999-14-9549; 999-86-7840; 999-93-4967; 999-90-2978; 999-14-3925 | None | None | None |
| `DRIVERS` | str | string | 21.30% | 78.70% | S99994775; S99961203; S99920007; S99972845; S99925188 | None | None | None |
| `PASSPORT` | str | string | 27.78% | 72.22% | X74721768X; X51581530X; X43158821X; X90441215X; X34855095X | None | None | None |
| `PREFIX` | str | string | 24.07% | 2.78% | Mr.; Mrs.; Ms. | None | None | None |
| `FIRST` | str | string | 0.00% | 99.07% | Rogelio17; Donte636; Ashlee14; Eartha927; Ariadna374 | None | None | None |
| `MIDDLE` | str | string | 24.07% | 75.00% | Richie600; Elmo857; Catrina144; Leanora120; Isabel214 | None | None | None |
| `LAST` | str | string | 0.00% | 91.67% | Volkman526; Daugherty69; Tromp100; McLaughlin530; Reilly981 | None | None | None |
| `SUFFIX` | str | string | 99.07% | 0.93% | MD | None | None | None |
| `MAIDEN` | str | string | 82.41% | 17.59% | Larson43; Wintheiser220; Prosacco716; Ondricka197; Schmeler639 | None | None | None |
| `MARITAL` | str | string | 39.81% | 3.70% | M; S; D; W | None | None | None |
| `RACE` | str | string | 0.00% | 4.63% | white; black; asian; other; native | None | None | None |
| `ETHNICITY` | str | string | 0.00% | 1.85% | nonhispanic; hispanic | None | None | None |
| `GENDER` | str | string | 0.00% | 1.85% | M; F | None | None | None |
| `BIRTHPLACE` | str | string | 0.00% | 73.15% | Boston  Massachusetts  US; Quincy  Massachusetts  US; Dedham  Massachusetts  US; Lexington  Massachusetts  US; Wesley  Saint Andrew Parish  DM | None | None | None |
| `ADDRESS` | str | string | 0.00% | 100.00% | 1062 Halvorson Underpass; 1019 Reilly Orchard Apt 29; 810 Wiegand Boulevard Suite 78; 1090 Runte Dam Apt 25; 421 Reilly Rest | None | None | None |
| `CITY` | str | string | 0.00% | 58.33% | Boston; Lowell; Quincy; Somerville; Worcester | None | None | None |
| `STATE` | str | string | 0.00% | 0.93% | Massachusetts | None | None | None |
| `COUNTY` | str | string | 0.00% | 12.04% | Middlesex County; Suffolk County; Worcester County; Norfolk County; Essex County | None | None | None |
| `FIPS` | float64 | float | 19.44% | 12.04% | 25017.0; 25025.0; 25027.0; 25021.0; 25009.0 | 25001.0 | 44007.0 | 25236.67816091954 |
| `ZIP` | int64 | integer | 0.00% | 61.11% | 0; 2151; 2138; 1940; 1089 | 0 | 2861 | 1568.0462962962963 |
| `LAT` | float64 | float | 0.00% | 100.00% | 42.354248842342805; 41.70601597716205; 42.48398517265568; 42.372662380253146; 42.31731083626712 | 41.47161251631839 | 42.69800674939124 | 42.320806631745526 |
| `LON` | float64 | float | 0.00% | 100.00% | -71.06877841138558; -70.31195643376097; -71.03446075559198; -70.9543376263957; -71.05410990962399 | -73.35543580884355 | -69.96631077816096 | -71.40585328243101 |
| `HEALTHCARE_EXPENSES` | float64 | float | 0.00% | 100.00% | 12223.69; 539230.03; 499804.16; 872.39; 72235.91 | 100.0 | 1016959.85 | 148908.33657407408 |
| `HEALTHCARE_COVERAGE` | float64 | float | 0.00% | 93.52% | 0.0; 173583.25; 737140.75; 1376278.98; 41094.85 | 0.0 | 1495032.66 | 253434.32129629632 |
| `INCOME` | int64 | integer | 0.00% | 91.67% | 26313; 8437; 68063; 56556; 132979 | 7688 | 968637 | 142419.9537037037 |

### payers.csv

- Rows: 10
- Columns: 22
- Duplicate rows: 0
- Candidate primary keys: Id, NAME, AMOUNT_COVERED, AMOUNT_UNCOVERED, REVENUE, COVERED_ENCOUNTERS, COVERED_MEDICATIONS, COVERED_PROCEDURES, COVERED_IMMUNIZATIONS, QOLS_AVG, MEMBER_MONTHS
- Likely ID-like columns: Id
- Likely foreign-key hints: Id

| Column | Pandas dtype | Inferred type | Null % | Unique % | Sample values | Min | Max | Mean |
|---|---|---|---|---|---|---|---|---|
| `Id` | str | string | 0.00% | 100.00% | a735bf55-83e9-331a-899d-a82a60b9f60c; df166300-5a78-3502-a46a-832842197811; d18ef2e6-ef40-324c-be54-34a5ee865625; 26aab0cd-6aba-3e1b-ac5b-05c8867e762c; b046940f-1664-3047-bca7-dfa76be352a4 | None | None | None |
| `NAME` | str | string | 0.00% | 100.00% | Medicare; Medicaid; Dual Eligible; Humana; Blue Cross Blue Shield | None | None | None |
| `OWNERSHIP` | str | string | 0.00% | 30.00% | PRIVATE; GOVERNMENT; NO_INSURANCE | None | None | None |
| `ADDRESS` | float64 | float | 100.00% | 0.00% |  | None | None | None |
| `CITY` | float64 | float | 100.00% | 0.00% |  | None | None | None |
| `STATE_HEADQUARTERED` | float64 | float | 100.00% | 0.00% |  | None | None | None |
| `ZIP` | float64 | float | 100.00% | 0.00% |  | None | None | None |
| `PHONE` | float64 | float | 100.00% | 0.00% |  | None | None | None |
| `AMOUNT_COVERED` | float64 | float | 0.00% | 100.00% | 4746079.19; 8189171.81; 1669718.18; 4481904.63; 3627799.73 | 0.0 | 8189171.81 | 2737090.67 |
| `AMOUNT_UNCOVERED` | float64 | float | 0.00% | 100.00% | 253947.29; 199955.82; 53363.38; 3006027.28; 1379866.78 | 53363.38 | 8718701.92 | 1609331.55 |
| `REVENUE` | float64 | float | 0.00% | 100.00% | 715780.8; 72280.0; 9260.0; 3252078.0; 2295780.0 | 0.0 | 3252078.0 | 1016106.5869999999 |
| `COVERED_ENCOUNTERS` | int64 | integer | 0.00% | 100.00% | 1988; 2657; 900; 2438; 1042 | 0 | 2657 | 1174.3 |
| `UNCOVERED_ENCOUNTERS` | int64 | integer | 0.00% | 20.00% | 0; 2850 | 0 | 2850 | 285.0 |
| `COVERED_MEDICATIONS` | int64 | integer | 0.00% | 100.00% | 2069; 853; 1256; 1224; 344 | 0 | 2069 | 691.4 |
| `UNCOVERED_MEDICATIONS` | int64 | integer | 0.00% | 20.00% | 0; 871 | 0 | 871 | 87.1 |
| `COVERED_PROCEDURES` | int64 | integer | 0.00% | 100.00% | 4380; 5533; 1872; 5873; 2580 | 0 | 5873 | 2667.5 |
| `UNCOVERED_PROCEDURES` | int64 | integer | 0.00% | 20.00% | 0; 6296 | 0 | 6296 | 629.6 |
| `COVERED_IMMUNIZATIONS` | int64 | integer | 0.00% | 100.00% | 451; 974; 107; 1026; 506 | 0 | 1026 | 429.5 |
| `UNCOVERED_IMMUNIZATIONS` | int64 | integer | 0.00% | 20.00% | 0; 1421 | 0 | 1421 | 142.1 |
| `UNIQUE_CUSTOMERS` | int64 | integer | 0.00% | 90.00% | 22; 33; 41; 9; 42 | 9 | 42 | 26.6 |
| `QOLS_AVG` | float64 | float | 0.00% | 100.00% | 0.7197986697942096; 0.9381225618271808; 0.7704125084705601; 0.9587718594328056; 0.5087843907135711 | 0.5087843907135711 | 0.9708543064901256 | 0.8591096600156286 |
| `MEMBER_MONTHS` | int64 | integer | 0.00% | 100.00% | 4356; 7296; 948; 9612; 7404 | 948 | 11892 | 5337.6 |

### procedures.csv

- Rows: 15985
- Columns: 10
- Duplicate rows: 0
- Candidate primary keys: None
- Likely ID-like columns: CODE, REASONCODE
- Likely foreign-key hints: CODE, REASONCODE

| Column | Pandas dtype | Inferred type | Null % | Unique % | Sample values | Min | Max | Mean |
|---|---|---|---|---|---|---|---|---|
| `START` | str | datetime | 0.00% | 84.47% | 2019-11-09T12:23:02Z; 2017-02-07T05:35:43Z; 2019-06-25T05:35:43Z; 2025-06-08T05:33:12Z; 2017-02-15T11:58:15Z | 2005-02-11 07:36:42+00:00 | 2026-07-15 05:51:05+00:00 | None |
| `STOP` | str | datetime | 0.00% | 91.36% | 2017-02-07T05:50:43Z; 2019-06-25T05:50:43Z; 2025-06-08T05:48:12Z; 2017-02-15T12:13:15Z; 2024-08-07T12:13:15Z | 2005-02-11 08:54:54+00:00 | 2026-07-15 06:00:17+00:00 | None |
| `PATIENT` | str | string | 0.00% | 0.68% | 7ad140ab-bfae-c3ae-20a3-2244b1c4d0e2; 5d84e6a3-b4bd-63d6-57c5-cada0916490d; 688c8453-ba6f-7dec-03c3-eaa27d6df1a4; 8d7f6a31-31ba-da9c-2b57-03ee0f7577a0; 01a006ce-6457-50c2-8e0a-fb58fc310a86 | None | None | None |
| `ENCOUNTER` | str | string | 0.00% | 24.10% | d0a482ef-d151-72a4-d727-486df6e2d57b; 93904045-6509-c7c6-db98-e69defd24afa; 531968a3-50fe-09ba-4b61-fa85fbd4713a; ba234ff2-cefe-dfee-16de-c1ae0438d3a0; 2eb14889-46f2-06de-5302-829eada1915e | None | None | None |
| `SYSTEM` | str | string | 0.00% | 0.01% | http://snomed.info/sct | None | None | None |
| `CODE` | int64 | integer | 0.00% | 1.55% | 171207006; 710824005; 430193006; 428211000124100; 265764009 | 3802001 | 456191000124101 | 21359192473528.664 |
| `DESCRIPTION` | str | string | 0.00% | 1.55% | Depression screening (procedure); Assessment of health and social care needs (procedure); Medication reconciliation (procedure); Assessment of substance use (procedure); Renal dialysis (procedure) | None | None | None |
| `BASE_COST` | float64 | float | 0.00% | 10.05% | 431.4; 862.8; 215.7; 450.32; 2261.69 | 0.41 | 91039.8 | 867.9042827650924 |
| `REASONCODE` | float64 | float | 54.54% | 0.41% | 66383009.0; 103697008.0; 72892002.0; 431857002.0; 44054006.0 | 6525002.0 | 108631000119101.0 | 180134325754.0483 |
| `REASONDESCRIPTION` | str | string | 54.54% | 0.41% | Gingivitis (disorder); Patient referral for dental care (procedure); Normal pregnancy (finding); Chronic kidney disease stage 4 (disorder); Diabetes mellitus type 2 (disorder) | None | None | None |

### providers.csv

- Rows: 278
- Columns: 13
- Duplicate rows: 0
- Candidate primary keys: Id, ORGANIZATION, NAME
- Likely ID-like columns: Id
- Likely foreign-key hints: Id

| Column | Pandas dtype | Inferred type | Null % | Unique % | Sample values | Min | Max | Mean |
|---|---|---|---|---|---|---|---|---|
| `Id` | str | string | 0.00% | 100.00% | 5a26622e-a116-3ad0-9175-53a9b54ea558; 0cb55105-b752-3f2d-aee8-6363e562091a; dcf488b6-def4-3dfe-b0cc-e6209fa474f8; 03cef1fd-0893-36cf-b2dd-1afc00a66a88; a0aa193d-bbc6-3046-9a66-982a18a4c8a6 | None | None | None |
| `ORGANIZATION` | str | string | 0.00% | 100.00% | 74ab949d-17ac-3309-83a0-13b4405c66aa; 17a4bae5-8b64-34d7-8144-b428be027bd0; e09d4c49-c2ef-3b0f-9a46-3719d9219306; ae88fd02-4911-3625-9e97-85b626ed3b0b; ab701a70-a658-340e-8f69-ee196a7d40c6 | None | None | None |
| `NAME` | str | string | 0.00% | 100.00% | Gabriel934 Reilly981; Lindsay928 Ward668; Ronald408 Emard19; Cherrie404 Farrell962; Bud153 Parisian75 | None | None | None |
| `GENDER` | str | string | 0.00% | 0.72% | F; M | None | None | None |
| `SPECIALITY` | str | string | 0.00% | 0.36% | GENERAL PRACTICE | None | None | None |
| `ADDRESS` | str | string | 0.00% | 94.24% | 88 WASHINGTON ST; 575 BEECH STREET; 1493 CAMBRIDGE ST; 1153 CENTRE ST; 759 CHESTNUT ST | None | None | None |
| `CITY` | str | string | 0.00% | 43.53% | BOSTON; WORCESTER; WALTHAM; SPRINGFIELD; LEOMINSTER | None | None | None |
| `STATE` | str | string | 0.00% | 0.36% | MA | None | None | None |
| `ZIP` | int64 | integer | 0.00% | 94.60% | 21504019; 25571406; 16071728; 27802465; 10406604 | 1104 | 27807340 | 18065422.482014388 |
| `LAT` | float64 | float | 0.00% | 91.37% | 42.3756401; 42.3917638; 42.54031915; 41.9062805; 42.5792583 | 41.44720825 | 42.7285558 | 42.31771048128359 |
| `LON` | float64 | float | 0.00% | 91.37% | -71.2358004; -71.0328284; -71.76312990486304; -71.09518121351795; -71.4378411 | -73.3715000043024 | -69.96772048551409 | -71.4366149262411 |
| `ENCOUNTERS` | int64 | integer | 0.00% | 38.13% | 1; 2; 6; 4; 8 | 1 | 1205 | 52.492805755395686 |
| `PROCEDURES` | int64 | integer | 0.00% | 0.36% | 0 | 0 | 0 | 0.0 |

### allergies.csv

- Rows: 134
- Columns: 15
- Duplicate rows: 0
- Candidate primary keys: None
- Likely ID-like columns: CODE
- Likely foreign-key hints: CODE

| Column | Pandas dtype | Inferred type | Null % | Unique % | Sample values | Min | Max | Mean |
|---|---|---|---|---|---|---|---|---|
| `START` | str | datetime | 0.00% | 16.42% | 2004-11-30; 2021-12-13; 1983-11-30; 1977-01-15; 2001-09-22 | 1957-03-10 00:00:00 | 2025-06-28 00:00:00 | None |
| `STOP` | float64 | float | 100.00% | 0.00% |  | None | None | None |
| `PATIENT` | str | string | 0.00% | 16.42% | 21060120-8398-1940-3dc7-1d7f56bb2674; 09c92ce0-6ff1-7234-956d-33795ad6648c; f238b3d3-c8f3-ef73-da73-8ddd4fd38bcb; fc2d1fb9-862d-a60c-581a-519f5470d866; 5b24c87b-6223-f5b4-51e9-82051159bd1d | None | None | None |
| `ENCOUNTER` | str | string | 0.00% | 16.42% | 21060120-8398-1940-6fb6-6c8323271b33; 09c92ce0-6ff1-7234-1223-14be0b8f8ce7; f238b3d3-c8f3-ef73-4f25-08601e9c71f2; fc2d1fb9-862d-a60c-b443-22f7f98f9bac; 5b24c87b-6223-f5b4-c18e-9181a217b85d | None | None | None |
| `CODE` | int64 | integer | 0.00% | 14.18% | 609328004; 264287008; 84489001; 256277009; 782576004 | 1191 | 442571000124108 | 16514201735387.604 |
| `SYSTEM` | str | string | 0.00% | 1.49% | SNOMED-CT; RxNorm | None | None | None |
| `DESCRIPTION` | str | string | 0.00% | 14.18% | Allergic disposition (finding); Animal dander (substance); Mold (organism); Grass pollen (substance); Tree pollen (substance) | None | None | None |
| `TYPE` | str | string | 0.00% | 1.49% | allergy; intolerance | None | None | None |
| `CATEGORY` | str | string | 0.00% | 2.24% | environment; food; medication | None | None | None |
| `REACTION1` | float64 | float | 53.73% | 9.70% | 878820003.0; 271807003.0; 21626009.0; 267036007.0; 247472004.0 | 21522001.0 | 878820003.0 | 323170778.2258065 |
| `DESCRIPTION1` | str | string | 53.73% | 9.70% | Rhinoconjunctivitis (disorder); Eruption of skin (disorder); Cutaneous hypersensitivity (disorder); Dyspnea (finding); Wheal (finding) | None | None | None |
| `SEVERITY1` | str | string | 53.73% | 2.24% | MODERATE; MILD; SEVERE | None | None | None |
| `REACTION2` | float64 | float | 75.37% | 8.96% | 271807003.0; 247472004.0; 402387002.0; 300359004.0; 56018004.0 | 49727002.0 | 878820003.0 | 293844367.6363636 |
| `DESCRIPTION2` | str | string | 75.37% | 8.96% | Eruption of skin (disorder); Wheal (finding); Allergic angioedema (disorder); Finding of vomiting (finding); Wheezing (finding) | None | None | None |
| `SEVERITY2` | str | string | 75.37% | 1.49% | MILD; MODERATE | None | None | None |

### careplans.csv

- Rows: 336
- Columns: 9
- Duplicate rows: 0
- Candidate primary keys: Id
- Likely ID-like columns: Id, CODE, REASONCODE
- Likely foreign-key hints: CODE, Id, REASONCODE

| Column | Pandas dtype | Inferred type | Null % | Unique % | Sample values | Min | Max | Mean |
|---|---|---|---|---|---|---|---|---|
| `Id` | str | string | 0.00% | 100.00% | f9ba83f7-9940-16ae-da23-1afb350f85c5; f9ba83f7-9940-16ae-d3d5-61d05274a18f; a1733070-046a-4506-8c85-aa65e58eabbf; f9ba83f7-9940-16ae-b178-d1c0c13d0e27; f9ba83f7-9940-16ae-5a8f-367d1dc87be7 | None | None | None |
| `START` | str | datetime | 0.00% | 94.94% | 2025-06-28; 2021-01-23; 2014-04-18; 1996-05-03; 2021-01-06 | 1957-02-20 00:00:00 | 2026-07-10 00:00:00 | None |
| `STOP` | str | datetime | 47.32% | 50.89% | 2019-12-01; 2023-12-30; 2021-11-17; 2021-11-15; 2025-04-28 | 2013-04-01 00:00:00 | 2026-06-17 00:00:00 | None |
| `PATIENT` | str | string | 0.00% | 28.87% | fc2d1fb9-862d-a60c-581a-519f5470d866; 7ad140ab-bfae-c3ae-20a3-2244b1c4d0e2; 6361e20a-35bf-68e3-def5-f001870db7c4; 53e4891a-9108-67ef-d973-3b6a98404249; f9ba83f7-9940-16ae-0854-24bd34bf1843 | None | None | None |
| `ENCOUNTER` | str | string | 0.00% | 97.02% | a85e45e4-9090-0a5e-360f-5172c93430f5; 885c1eeb-1b4c-8a3a-13e3-7751e06e95cd; ba234ff2-cefe-dfee-c9c3-9a33b5eef6a1; 5d84e6a3-b4bd-63d6-4ebd-b2e27ee06044; 08d6836a-cefb-bc53-f38c-e28ff710007f | None | None | None |
| `CODE` | int64 | integer | 0.00% | 8.33% | 53950000; 735985000; 134435003; 384758001; 385691007 | 47387005 | 773513001 | 430582281.90178573 |
| `DESCRIPTION` | str | string | 0.00% | 8.33% | Respiratory therapy (procedure); Diabetes self management plan (record artifact); Routine antenatal care (regime/therapy); Self-care interventions (procedure); Fracture care (regime/therapy) | None | None | None |
| `REASONCODE` | float64 | float | 49.70% | 11.31% | 714628002.0; 59621000.0; 44465007.0; 55822004.0; 65966004.0 | 16114001.0 | 714628002.0 | 276323494.84023666 |
| `REASONDESCRIPTION` | str | string | 49.70% | 11.31% | Prediabetes (finding); Essential hypertension (disorder); Sprain of ankle (disorder); Hyperlipidemia (disorder); Fracture of forearm (disorder) | None | None | None |

### devices.csv

- Rows: 574
- Columns: 7
- Duplicate rows: 0
- Candidate primary keys: UDI
- Likely ID-like columns: CODE
- Likely foreign-key hints: CODE

| Column | Pandas dtype | Inferred type | Null % | Unique % | Sample values | Min | Max | Mean |
|---|---|---|---|---|---|---|---|---|
| `START` | str | datetime | 0.00% | 93.03% | 2020-05-27T00:17:20Z; 2018-10-05T07:51:50Z; 2018-10-05T15:47:50Z; 2023-08-15T06:02:59Z; 2023-12-17T05:35:43Z | 1963-08-29 16:38:35+00:00 | 2026-06-18 19:37:22+00:00 | None |
| `STOP` | str | datetime | 37.98% | 58.19% | 2018-10-05T15:47:50Z; 2023-08-15T06:02:59Z; 2023-12-30T04:16:04Z; 1993-03-12T22:13:29Z; 1999-05-21T11:56:05Z | 1993-03-12 22:13:29+00:00 | 2026-06-18 19:37:22+00:00 | None |
| `PATIENT` | str | string | 0.00% | 16.72% | 688c8453-ba6f-7dec-03c3-eaa27d6df1a4; 7ad140ab-bfae-c3ae-20a3-2244b1c4d0e2; 5d84e6a3-b4bd-63d6-57c5-cada0916490d; 1e7909f8-39b2-3c7e-1fda-a6c3256dc061; 8d7f6a31-31ba-da9c-2b57-03ee0f7577a0 | None | None | None |
| `ENCOUNTER` | str | string | 0.00% | 85.71% | fc2d1fb9-862d-a60c-60f9-5e938152d4de; 688c8453-ba6f-7dec-380c-6709eb947cf1; 1e7909f8-39b2-3c7e-04e9-2658711edea8; bad853b3-250e-3dc8-c344-9942c8ea1195; 5d84e6a3-b4bd-63d6-a795-da5ff05d423c | None | None | None |
| `CODE` | int64 | integer | 0.00% | 3.14% | 706298007; 225738002; 337414009; 170615005; 702172008 | 8060009 | 1255320005 | 522465885.71602786 |
| `DESCRIPTION` | str | string | 0.00% | 3.14% | Dental x-ray system (physical object); Operating room (environment); Blood glucose meter (physical object); Home nebulizer (physical object); Home continuous positive airway pressure unit (physical object) | None | None | None |
| `UDI` | str | string | 0.00% | 100.00% | (01)11372462729230(11)190501(17)440515(10)3862750236860375580(21)233686208761462; (01)89608750270142(11)200616(17)450701(10)65960779(21)7305788934281285703; (01)30778793088250(11)220628(17)470713(10)4120884428902(21)210709023319; (01)25140640911828(11)200506(17)450521(10)2462860384(21)18960850704450906; (01)60669881227099(11)200506(17)450521(10)63491(21)7420377169249276 | None | None | None |

### imaging_studies.csv

- Rows: 744
- Columns: 13
- Duplicate rows: 0
- Candidate primary keys: INSTANCE_UID
- Likely ID-like columns: Id, SERIES_UID, BODYSITE_CODE, MODALITY_CODE, INSTANCE_UID, SOP_CODE, PROCEDURE_CODE
- Likely foreign-key hints: Id

| Column | Pandas dtype | Inferred type | Null % | Unique % | Sample values | Min | Max | Mean |
|---|---|---|---|---|---|---|---|---|
| `Id` | str | string | 0.00% | 73.52% | d20a36fc-23ba-8462-ac75-f6e0726d4b95; d20a36fc-23ba-8462-6148-7188e245386b; d20a36fc-23ba-8462-36ba-b6300e514431; d20a36fc-23ba-8462-c81d-1a0ed3e170f6; d20a36fc-23ba-8462-783f-8e59153395e8 | None | None | None |
| `DATE` | str | datetime | 0.00% | 72.98% | 2010-05-21T04:25:48Z; 2017-03-15T07:01:52Z; 2017-03-15T07:04:21Z; 2018-02-08T07:18:21Z; 2018-02-08T07:23:08Z | 1991-08-05 07:36:49+00:00 | 2026-06-26 15:37:13+00:00 | None |
| `PATIENT` | str | string | 0.00% | 12.37% | 7ad140ab-bfae-c3ae-20a3-2244b1c4d0e2; d20a36fc-23ba-8462-bf39-864000fbf25f; ba234ff2-cefe-dfee-935a-8ea2378da8c2; 53e4891a-9108-67ef-d973-3b6a98404249; 5d84e6a3-b4bd-63d6-57c5-cada0916490d | None | None | None |
| `ENCOUNTER` | str | string | 0.00% | 61.29% | 9277390b-8a92-52e1-5c34-b94c71d44330; d20a36fc-23ba-8462-096f-7be6fb49318a; d20a36fc-23ba-8462-fdc4-3c96be95f325; d20a36fc-23ba-8462-d22a-34219c6cfbc8; d20a36fc-23ba-8462-e4ab-e68c22d2be1a | None | None | None |
| `SERIES_UID` | str | string | 0.00% | 73.52% | 1.2.840.99999999.1.24453434.1274415948075; 1.2.840.99999999.1.74886279.1489561312075; 1.2.840.99999999.1.87238139.1489561461075; 1.2.840.99999999.1.23938552.1518074301075; 1.2.840.99999999.1.90084952.1518074588075 | None | None | None |
| `BODYSITE_CODE` | int64 | integer | 0.00% | 1.61% | 181171005; 700016008; 51185008; 80891009; 40983000 | 344001 | 700016008 | 374891120.5094086 |
| `BODYSITE_DESCRIPTION` | str | string | 0.00% | 1.61% | Entire retina (body structure); Structure of region of internal part of mouth (body structure); Thoracic structure (body structure); Heart structure (body structure); Structure of upper extremity between shoulder and elbow (body structure) | None | None | None |
| `MODALITY_CODE` | str | string | 0.00% | 0.67% | DX; OP; OPT; US; CR | None | None | None |
| `MODALITY_DESCRIPTION` | str | string | 0.00% | 0.67% | Digital Radiography; Ophthalmic Photography; Ophthalmic Tomography; Ultrasound; Computed Radiography | None | None | None |
| `INSTANCE_UID` | str | string | 0.00% | 100.00% | 1.2.840.99999999.1.1.96742343.1558486538522; 1.2.840.99999999.1.1.75148782.1594143405895; 1.2.840.99999999.1.1.24208352.1658255797895; 1.2.840.99999999.1.1.77148086.1590538640522; 1.2.840.99999999.1.1.81914273.1591140021522 | None | None | None |
| `SOP_CODE` | str | string | 0.00% | 0.81% | 1.2.840.10008.5.1.4.1.1.1.3; 1.2.840.10008.5.1.4.1.1.77.1.5.1; 1.2.840.10008.5.1.4.1.1.77.1.5.4; 1.2.840.10008.5.1.4.1.1.1.1; 1.2.840.10008.5.1.4.1.1.3.1 | None | None | None |
| `SOP_DESCRIPTION` | str | string | 0.00% | 0.94% | Digital Intra-Oral X-Ray Image Storage - For Presentation; Ophthalmic Photography 8 Bit Image Storage; Ophthalmic Tomography Image; Digital X-Ray Image Storage; Digital X-Ray Image Storage – for Presentation | None | None | None |
| `PROCEDURE_CODE` | int64 | integer | 0.00% | 1.88% | 241046008; 314971001; 700070005; 399208008; 40701008 | 40701008 | 426701000119108 | 573905570048.1841 |

### immunizations.csv

- Rows: 1731
- Columns: 6
- Duplicate rows: 0
- Candidate primary keys: None
- Likely ID-like columns: CODE
- Likely foreign-key hints: CODE

| Column | Pandas dtype | Inferred type | Null % | Unique % | Sample values | Min | Max | Mean |
|---|---|---|---|---|---|---|---|---|
| `DATE` | str | datetime | 0.00% | 64.47% | 2025-05-12T21:53:08Z; 2025-07-14T21:53:08Z; 2025-10-13T21:53:08Z; 2026-04-13T21:53:08Z; 2021-05-21T06:41:59Z | 2005-10-30 05:33:12+00:00 | 2026-07-13 21:53:08+00:00 | None |
| `PATIENT` | str | string | 0.00% | 6.24% | 062ce52a-5823-aeb4-e0d1-d514baf42a38; 4c756282-9faf-4e7b-1689-3e3a3cb39537; 6c3ee07c-34a7-15d2-ec2f-a8f6e7d6323f; a0873afa-1674-1ef3-ac16-c39738e22bba; 26be634c-60c8-bec3-3c2a-92aa53cbecf5 | None | None | None |
| `ENCOUNTER` | str | string | 0.00% | 64.88% | 8dc1eb80-5a2e-3f58-9475-25837dc546b0; 8dc1eb80-5a2e-3f58-c2d7-fc1f10910947; 8dc1eb80-5a2e-3f58-c3a2-dc828ea8b4c1; 8dc1eb80-5a2e-3f58-fdf7-fa4cf4d8228e; f691e124-1107-034e-cf5d-82804c3ad57e | None | None | None |
| `CODE` | int64 | integer | 0.00% | 1.21% | 140; 20; 133; 208; 113 | 3 | 212 | 111.86943963027151 |
| `DESCRIPTION` | str | string | 0.00% | 1.21% | Influenza  split virus  trivalent  PF; DTaP; Pneumococcal conjugate PCV 13; COVID-19  mRNA  LNP-S  PF  30 mcg/0.3 mL dose; Td (adult)  5 Lf tetanus toxoid  preservative free  adsorbed | None | None | None |
| `BASE_COST` | float64 | float | 0.00% | 0.06% | 136.0 | 136.0 | 136.0 | 136.0 |

### medications.csv

- Rows: 4522
- Columns: 13
- Duplicate rows: 0
- Candidate primary keys: None
- Likely ID-like columns: CODE, REASONCODE
- Likely foreign-key hints: CODE, REASONCODE

| Column | Pandas dtype | Inferred type | Null % | Unique % | Sample values | Min | Max | Mean |
|---|---|---|---|---|---|---|---|---|
| `START` | str | datetime | 0.00% | 57.05% | 2020-06-15T07:01:15Z; 2023-11-27T07:01:15Z; 2016-02-29T07:01:15Z; 2016-09-05T07:01:15Z; 2018-03-12T07:01:15Z | 1964-08-11 11:11:40+00:00 | 2026-07-13 01:39:01+00:00 | None |
| `STOP` | str | datetime | 6.10% | 54.00% | 2020-06-15T07:01:15Z; 2023-11-27T07:01:15Z; 2016-09-05T07:01:15Z; 2018-03-12T07:01:15Z; 2018-05-28T07:01:15Z | 2006-01-12 05:33:12+00:00 | 2026-07-12 04:58:52+00:00 | None |
| `PATIENT` | str | string | 0.00% | 2.32% | 7ad140ab-bfae-c3ae-20a3-2244b1c4d0e2; 688c8453-ba6f-7dec-03c3-eaa27d6df1a4; 5d84e6a3-b4bd-63d6-57c5-cada0916490d; 01a006ce-6457-50c2-8e0a-fb58fc310a86; 53e4891a-9108-67ef-d973-3b6a98404249 | None | None | None |
| `PAYER` | str | string | 0.00% | 0.22% | a735bf55-83e9-331a-899d-a82a60b9f60c; d18ef2e6-ef40-324c-be54-34a5ee865625; 26aab0cd-6aba-3e1b-ac5b-05c8867e762c; df166300-5a78-3502-a46a-832842197811; 734afbd6-4794-363b-9bc0-6a3981533ed5 | None | None | None |
| `ENCOUNTER` | str | string | 0.00% | 55.77% | a03e9688-2e96-60c9-0893-f74323681cc5; c1e9a9fb-45ec-4ee4-9822-a6f130ce95c1; 688c8453-ba6f-7dec-e599-574ee491e288; 885c1eeb-1b4c-8a3a-ad24-1e156a22d3c5; 688c8453-ba6f-7dec-28a3-5435453dee59 | None | None | None |
| `CODE` | int64 | integer | 0.00% | 2.96% | 205923; 106892; 314076; 310798; 1535362 | 106258 | 2001499 | 519076.8042901371 |
| `DESCRIPTION` | str | string | 0.00% | 2.99% | 1 ML Epoetin Alfa 4000 UNT/ML Injection [Epogen]; insulin isophane  human 70 UNT/ML / insulin  regular  human 30 UNT/ML Injectable Suspension [Humulin]; lisinopril 10 MG Oral Tablet; Hydrochlorothiazide 25 MG Oral Tablet; sodium fluoride 0.0272 MG/MG Oral Gel | None | None | None |
| `BASE_COST` | float64 | float | 0.00% | 21.76% | 129.94; 0.91; 29.21; 0.45; 30.67 | 0.01 | 2293.2 | 93.9805882352941 |
| `PAYER_COVERAGE` | float64 | float | 0.00% | 14.68% | 0.0; 103.95; 23.37; 0.73; 94.94 | 0.0 | 1834.56 | 53.31866651923928 |
| `DISPENSES` | int64 | integer | 0.00% | 1.61% | 1; 3; 12; 4; 2 | 1 | 754 | 7.255417956656347 |
| `TOTALCOST` | float64 | float | 0.00% | 24.94% | 129.94; 0.91; 389.82; 29.21; 30.67 | 0.01 | 353519.19 | 1027.5567558602388 |
| `REASONCODE` | float64 | float | 24.39% | 0.73% | 59621000.0; 271737000.0; 44054006.0; 103697008.0; 714628002.0 | 10509002.0 | 714628002.0 | 140570029.3062299 |
| `REASONDESCRIPTION` | str | string | 24.39% | 0.73% | Essential hypertension (disorder); Anemia (disorder); Diabetes mellitus type 2 (disorder); Patient referral for dental care (procedure); Prediabetes (finding) | None | None | None |

### observations.csv

- Rows: 75343
- Columns: 9
- Duplicate rows: 14
- Candidate primary keys: None
- Likely ID-like columns: CODE
- Likely foreign-key hints: CODE

| Column | Pandas dtype | Inferred type | Null % | Unique % | Sample values | Min | Max | Mean |
|---|---|---|---|---|---|---|---|---|
| `DATE` | str | datetime | 0.00% | 10.03% | 2019-07-22T07:01:15Z; 2016-09-05T07:01:15Z; 2018-03-12T07:01:15Z; 2018-05-28T07:01:15Z; 2018-12-24T07:01:15Z | 2005-10-30 05:33:12+00:00 | 2026-07-15 18:26:44+00:00 | None |
| `PATIENT` | str | string | 0.00% | 0.14% | 5d84e6a3-b4bd-63d6-57c5-cada0916490d; 7ad140ab-bfae-c3ae-20a3-2244b1c4d0e2; 688c8453-ba6f-7dec-03c3-eaa27d6df1a4; 01a006ce-6457-50c2-8e0a-fb58fc310a86; 8d7f6a31-31ba-da9c-2b57-03ee0f7577a0 | None | None | None |
| `ENCOUNTER` | str | string | 3.99% | 3.76% | a03e9688-2e96-60c9-0893-f74323681cc5; c1e9a9fb-45ec-4ee4-9822-a6f130ce95c1; 9277390b-8a92-52e1-5c34-b94c71d44330; 688c8453-ba6f-7dec-e599-574ee491e288; 8d7f6a31-31ba-da9c-c4c5-230087a6e666 | None | None | None |
| `CATEGORY` | str | string | 3.99% | 0.01% | laboratory; survey; vital-signs; social-history; exam | None | None | None |
| `CODE` | str | string | 0.00% | 0.32% | 72514-3; 8462-4; 8480-6; 29463-7; 8867-4 | None | None | None |
| `DESCRIPTION` | str | string | 0.00% | 0.32% | Pain severity - 0-10 verbal numeric rating [Score] - Reported; Diastolic Blood Pressure; Systolic Blood Pressure; Body Weight; Heart rate | None | None | None |
| `VALUE` | str | string | 0.00% | 4.13% | No; 1.0; Yes; 0.0; 2.0 | None | None | None |
| `UNITS` | str | string | 27.96% | 0.06% | mg/dL; {nominal}; mmol/L; {score}; mm[Hg] | None | None | None |
| `TYPE` | str | string | 0.00% | 0.00% | numeric; text | None | None | None |

### organizations.csv

- Rows: 278
- Columns: 11
- Duplicate rows: 0
- Candidate primary keys: Id
- Likely ID-like columns: Id
- Likely foreign-key hints: Id

| Column | Pandas dtype | Inferred type | Null % | Unique % | Sample values | Min | Max | Mean |
|---|---|---|---|---|---|---|---|---|
| `Id` | str | string | 0.00% | 100.00% | 74ab949d-17ac-3309-83a0-13b4405c66aa; 17a4bae5-8b64-34d7-8144-b428be027bd0; e09d4c49-c2ef-3b0f-9a46-3719d9219306; ae88fd02-4911-3625-9e97-85b626ed3b0b; ab701a70-a658-340e-8f69-ee196a7d40c6 | None | None | None |
| `NAME` | str | string | 0.00% | 94.24% | MARTHA'S VINEYARD HOSPITAL INC; HARBOR HEALTH SERVICES INC; UMASS MEMORIAL HEALTHALLIANCE CLINTON HOSPITAL INC; BAYADA HOME HEALTH CARE  INC; SOUTH END COMMUNITY HEALTH CENTER INC | None | None | None |
| `ADDRESS` | str | string | 0.00% | 94.24% | 88 WASHINGTON ST; 575 BEECH STREET; 1493 CAMBRIDGE ST; 1153 CENTRE ST; 759 CHESTNUT ST | None | None | None |
| `CITY` | str | string | 0.00% | 43.53% | BOSTON; WORCESTER; WALTHAM; SPRINGFIELD; LEOMINSTER | None | None | None |
| `STATE` | str | string | 0.00% | 0.36% | MA | None | None | None |
| `ZIP` | int64 | integer | 0.00% | 94.60% | 21504019; 25571406; 16071728; 27802465; 10406604 | 1104 | 27807340 | 18065422.482014388 |
| `LAT` | float64 | float | 0.00% | 91.37% | 42.3756401; 42.3917638; 42.54031915; 41.9062805; 42.5792583 | 41.44720825 | 42.7285558 | 42.31771048128359 |
| `LON` | float64 | float | 0.00% | 91.37% | -71.2358004; -71.0328284; -71.76312990486304; -71.09518121351795; -71.4378411 | -73.3715000043024 | -69.96772048551409 | -71.4366149262411 |
| `PHONE` | str | string | 0.00% | 95.32% | 5086930410; 4135345691; 6174252000; 6176651000; 6179837470 | None | None | None |
| `REVENUE` | float64 | float | 0.00% | 0.36% | 0.0 | 0.0 | 0.0 | 0.0 |
| `UTILIZATION` | int64 | integer | 0.00% | 38.13% | 1; 2; 6; 4; 8 | 1 | 1205 | 52.492805755395686 |

### payer_transitions.csv

- Rows: 3806
- Columns: 8
- Duplicate rows: 0
- Candidate primary keys: None
- Likely ID-like columns: MEMBERID
- Likely foreign-key hints: None

| Column | Pandas dtype | Inferred type | Null % | Unique % | Sample values | Min | Max | Mean |
|---|---|---|---|---|---|---|---|---|
| `PATIENT` | str | string | 0.00% | 2.84% | d20a36fc-23ba-8462-bf39-864000fbf25f; 93904045-6509-c7c6-9b28-aff82a8e7181; 8d7f6a31-31ba-da9c-2b57-03ee0f7577a0; f8bbf1e4-7bb5-dc68-a7a8-b509ff9a7832; ba234ff2-cefe-dfee-935a-8ea2378da8c2 | None | None | None |
| `MEMBERID` | str | string | 23.49% | 61.32% | 80c747ab-dc05-2bca-2b64-bbecd414ac6f; a00b5c95-fed5-f472-2a65-cbb725992bc3; a85e45e4-9090-0a5e-2a57-fe47a468c4f5; 373e1deb-b6b2-b528-ced1-8e67cf846aa4; 5d84e6a3-b4bd-63d6-554b-5c0f4e0f12c1 | None | None | None |
| `START_DATE` | str | datetime | 0.00% | 89.12% | 2005-10-30T05:33:12Z; 2006-11-05T05:33:12Z; 2007-11-04T05:33:12Z; 1969-04-28T07:01:15Z; 1970-04-27T07:01:15Z | 1969-01-11 07:48:23+00:00 | 2026-07-18 12:23:02+00:00 | None |
| `END_DATE` | str | datetime | 0.00% | 89.33% | 2025-10-07T00:02:02Z; 2006-11-05T05:33:12Z; 2007-11-04T05:33:12Z; 1970-04-27T07:01:15Z; 1971-04-26T07:01:15Z | 1970-01-17 07:48:23+00:00 | 2027-07-15 18:26:44+00:00 | None |
| `PAYER` | str | string | 0.00% | 0.26% | e03e23c9-4df1-3eb6-a62d-f70f02301496; 26aab0cd-6aba-3e1b-ac5b-05c8867e762c; df166300-5a78-3502-a46a-832842197811; d31fccc3-1767-390d-966a-22a5156f4219; a735bf55-83e9-331a-899d-a82a60b9f60c | None | None | None |
| `SECONDARY_PAYER` | str | string | 92.46% | 0.03% | b046940f-1664-3047-bca7-dfa76be352a4 | None | None | None |
| `PLAN_OWNERSHIP` | str | string | 23.49% | 0.08% | Self; Guardian; Spouse | None | None | None |
| `OWNER_NAME` | str | string | 23.49% | 5.60% | Guadalupe206 Valencia279; Mohammad578 Kshlerin58; Joaquín233 Camarillo982; Chasidy481 Ellis535 Grant908; Alfonso758 Ulloa39 | None | None | None |

### supplies.csv

- Rows: 2754
- Columns: 6
- Duplicate rows: 16
- Candidate primary keys: None
- Likely ID-like columns: CODE
- Likely foreign-key hints: CODE

| Column | Pandas dtype | Inferred type | Null % | Unique % | Sample values | Min | Max | Mean |
|---|---|---|---|---|---|---|---|---|
| `DATE` | str | datetime | 0.00% | 36.82% | 2021-01-03; 2019-01-13; 2025-09-25; 2021-01-11; 2021-05-10 | 1972-06-19 00:00:00 | 2026-07-11 00:00:00 | None |
| `PATIENT` | str | string | 0.00% | 3.59% | 688c8453-ba6f-7dec-03c3-eaa27d6df1a4; 5d84e6a3-b4bd-63d6-57c5-cada0916490d; 7ad140ab-bfae-c3ae-20a3-2244b1c4d0e2; c1e9a9fb-45ec-4ee4-c946-4ffc5dfa93ea; 1e7909f8-39b2-3c7e-1fda-a6c3256dc061 | None | None | None |
| `ENCOUNTER` | str | string | 0.00% | 39.18% | a03e9688-2e96-60c9-0893-f74323681cc5; c1e9a9fb-45ec-4ee4-9822-a6f130ce95c1; 1e7909f8-39b2-3c7e-6d58-cada413a83ca; 688c8453-ba6f-7dec-99fa-fbe5327eb853; 688c8453-ba6f-7dec-bc94-b9d239fed2fe | None | None | None |
| `CODE` | int64 | integer | 0.00% | 0.80% | 277183007; 1230220004; 469020004; 337388004; 1137596000 | 972002 | 1230220004 | 598529182.1612201 |
| `DESCRIPTION` | str | string | 0.00% | 0.80% | Dental equipment (physical object); Conventional release periodontal gel (dose form); Dental floss (physical object); Blood glucose testing strips (physical object); Blood lancet (physical object) | None | None | None |
| `QUANTITY` | int64 | integer | 0.00% | 0.29% | 1; 50; 100; 5; 2 | 1 | 100 | 13.932461873638344 |
