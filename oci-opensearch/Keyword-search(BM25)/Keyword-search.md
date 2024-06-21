# Pre-requisites
You have to have an existing OpenSearch cluster and have to be able to connect to the Dashboard, to perform all of the steps.
## Introduction

In this lab, you will perform Keyword search (BM25).
Estimated Time: 15 minutes

### Objectives

In this lab, you will use an existing Cluster.

Use the steps in this walkthrough to create an index and use the keyword search capabilities of OCI Search with OpenSearch.


## Step 1: Prerequisites

Confirm that the OpenSearch cluster is version 2.11 or higher. To create a cluster, see Creating an OpenSearch Cluster (LABs 1,2).
First connect to the OpenSearch Dashboard (you have to provide the username/password) and go to **Management** and click on **Dev Tools**. You will be able to type the commands in the Console.
Please refer to **LAB2** **Task3** on how to connect to the OpenSearch Dashboard.

## Step2: Create a Search Index without the k-NN plugin
Connect to the Dashboard and go to **Management** and click on **Dev Tools**. You will be able to type the commands in the Console.
- Create a Search Index without the k-NN plugin


This section describes the steps to create an index without using an ingestion pipeline.
1. Create a search index, as shown in the following example:
```html
   <copy>PUT /conversation-demo-index
{
  "settings": {
    "index": {
      "number_of_shards": 1,
      "number_of_replicas": 0
    }
  },
  "mappings": {
    "properties": {
      "title": {
        "type": "text"
      },
      "text": {
        "type": "text"
      }
    }
  }
}</copy>
```
2. Ingest data into the index, as shown in the following example:
```html
   <copy>PUT /conversation-demo-index/_doc/1
{
    "text": "The emergence of resistance of bacteria to antibiotics is a common phenomenon. Emergence of resistance often reflects evolutionary processes that take place during antibiotic therapy. The antibiotic treatment may select for bacterial strains with physiologically or genetically enhanced capacity to survive high doses of antibiotics. Under certain conditions, it may result in preferential growth of resistant bacteria, while growth of susceptible bacteria is inhibited by the drug. For example, antibacterial selection for strains having previously acquired antibacterial-resistance genes was demonstrated in 1943 by the Luria–Delbrück experiment. Antibiotics such as penicillin and erythromycin, which used to have a high efficacy against many bacterial species and strains, have become less effective, due to the increased resistance of many bacterial strains."
   
}
GET /conversation-demo-index/_doc/1
PUT /conversation-demo-index/_doc/2
{
  "text": "The successful outcome of antimicrobial therapy with antibacterial compounds depends on several factors. These include host defense mechanisms, the location of infection, and the pharmacokinetic and pharmacodynamic properties of the antibacterial. A bactericidal activity of antibacterials may depend on the bacterial growth phase, and it often requires ongoing metabolic activity and division of bacterial cells. These findings are based on laboratory studies, and in clinical settings have also been shown to eliminate bacterial infection. Since the activity of antibacterials depends frequently on its concentration, in vitro characterization of antibacterial activity commonly includes the determination of the minimum inhibitory concentration and minimum bactericidal concentration of an antibacterial. To predict clinical outcome, the antimicrobial activity of an antibacterial is usually combined with its pharmacokinetic profile, and several pharmacological parameters are used as markers of drug efficacy."
}
 
PUT /conversation-demo-index/_doc/3
{
  "text": "Antibacterial antibiotics are commonly classified based on their mechanism of action, chemical structure, or spectrum of activity. Most target bacterial functions or growth processes. Those that target the bacterial cell wall (penicillins and cephalosporins) or the cell membrane (polymyxins), or interfere with essential bacterial enzymes (rifamycins, lipiarmycins, quinolones, and sulfonamides) have bactericidal activities. Those that target protein synthesis (macrolides, lincosamides and tetracyclines) are usually bacteriostatic (with the exception of bactericidal aminoglycosides). Further categorization is based on their target specificity. Narrow-spectrum antibacterial antibiotics target specific types of bacteria, such as Gram-negative or Gram-positive bacteria, whereas broad-spectrum antibiotics affect a wide range of bacteria. Following a 40-year hiatus in discovering new classes of antibacterial compounds, four new classes of antibacterial antibiotics have been brought into clinical use in the late 2000s and early 2010s: cyclic lipopeptides (such as daptomycin), glycylcyclines (such as tigecycline), oxazolidinones (such as linezolid), and lipiarmycins (such as fidaxomicin)"
}
 
 
PUT /conversation-demo-index/_doc/4
{
  "text": "The Desert Land Act of 1877 was passed to allow settlement of arid lands in the west and allotted 640 acres (2.6 km2) to settlers for a fee of $.25 per acre and a promise to irrigate the land. After three years, a fee of one dollar per acre would be paid and the land would be owned by the settler. This act brought mostly cattle and sheep ranchers into Montana, many of whom grazed their herds on the Montana prairie for three years, did little to irrigate the land and then abandoned it without paying the final fees. Some farmers came with the arrival of the Great Northern and Northern Pacific Railroads throughout the 1880s and 1890s, though in relatively small numbers"
}
 
PUT /conversation-demo-index/_doc/5
{
  "text": "In the early 1900s, James J. Hill of the Great Northern began promoting settlement in the Montana prairie to fill his trains with settlers and goods. Other railroads followed suit. In 1902, the Reclamation Act was passed, allowing irrigation projects to be built in Montana's eastern river valleys. In 1909, Congress passed the Enlarged Homestead Act that expanded the amount of free land from 160 to 320 acres (0.6 to 1.3 km2) per family and in 1912 reduced the time to prove up on a claim to three years. In 1916, the Stock-Raising Homestead Act allowed homesteads of 640 acres in areas unsuitable for irrigation.  This combination of advertising and changes in the Homestead Act drew tens of thousands of homesteaders, lured by free land, with World War I bringing particularly high wheat prices. In addition, Montana was going through a temporary period of higher-than-average precipitation. Homesteaders arriving in this period were known as Honyockers, or scissorbills. Though the word honyocker, possibly derived from the ethnic slur hunyak, was applied in a derisive manner at homesteaders as being greenhorns, new at his business or unprepared, the reality was that a majority of these new settlers had previous farming experience, though there were also many who did not"
}
 
PUT /conversation-demo-index/_doc/6
{
  "text": "In June 1917, the U.S. Congress passed the Espionage Act of 1917 which was later extended by the Sedition Act of 1918, enacted in May 1918. In February 1918, the Montana legislature had passed the Montana Sedition Act, which was a model for the federal version. In combination, these laws criminalized criticism of the U.S. government, military, or symbols through speech or other means. The Montana Act led to the arrest of over 200 individuals and the conviction of 78, mostly of German or Austrian descent. Over 40 spent time in prison. In May 2006, then-Governor Brian Schweitzer posthumously issued full pardons for all those convicted of violating the Montana Sedition Act."
}
 
PUT /conversation-demo-index/_doc/7
{
  "text": "When the U.S. entered World War II on December 8, 1941, many Montanans already had enlisted in the military to escape the poor national economy of the previous decade. Another 40,000-plus Montanans entered the armed forces in the first year following the declaration of war, and over 57,000 joined up before the war ended. These numbers constituted about 10 percent of the state's total population, and Montana again contributed one of the highest numbers of soldiers per capita of any state. Many Native Americans were among those who served, including soldiers from the Crow Nation who became Code Talkers. At least 1500 Montanans died in the war. Montana also was the training ground for the First Special Service Force or Devil's Brigade a joint U.S-Canadian commando-style force that trained at Fort William Henry Harrison for experience in mountainous and winter conditions before deployment. Air bases were built in Great Falls, Lewistown, Cut Bank and Glasgow, some of which were used as staging areas to prepare planes to be sent to allied forces in the Soviet Union. During the war, about 30 Japanese balloon bombs were documented to have landed in Montana, though no casualties nor major forest fires were attributed to them"
}</copy>
```
Because this procedure doesn't use an ingestion pipeline with this index, embeddings aren’t generated for text documents during the ingestion. This means that only BM25 search is used to retrieve relevant documents.

After creating a search index without the k-NN plugin, when you run the following command to check an indexed document, only the text is returned, as follows:

Request:
```html
   <copy>GET /conversation-demo-index/_doc/1</copy>
```
Response:
```html
{
  "_index": "conversation-demo-index",
  "_id": "1",
  "_version": 1,
  "_seq_no": 0,
  "_primary_term": 1,
  "found": true,
  "_source": {
    "text": "The emergence of resistance of bacteria to antibiotics is a common phenomenon. Emergence of resistance often reflects evolutionary processes that take place during antibiotic therapy. The antibiotic treatment may select for bacterial strains with physiologically or genetically enhanced capacity to survive high doses of antibiotics. Under certain conditions, it may result in preferential growth of resistant bacteria, while growth of susceptible bacteria is inhibited by the drug. For example, antibacterial selection for strains having previously acquired antibacterial-resistance genes was demonstrated in 1943 by the Luria–Delbrück experiment. Antibiotics such as penicillin and erythromycin, which used to have a high efficacy against many bacterial species and strains, have become less effective, due to the increased resistance of many bacterial strains."
  }
}   
```
## Step3: Run a keyword search
The following example query searches for the words antibiotics in the conversation-demo-index:

```html
<copy>GET conversation-demo-index/_search
{
  "query": {
    "match": {
      "text": "Espionage Act"
    }
  }
}</copy>
```

The response contains the matching documents, each with a relevance score in the _score field:

## Acknowledgements

* **Author** - Landry Kezebou Yankam
* **Last Updated By/Date** - George Csaba, June 2024