# Introduction

## About this workshop

Machine Learning and Artificial Intelligence tools are unprecedentedly changing modern healthcare. Given the speed of innovation and global outreach, it can be challenging for patients and healthcare providers to stay abreast of the latest technological advances and how they will impact the future. 

In this workshop, we will show how Artificial Intelligence (AI) and Machine Learning (ML) are helping identify breast cancer using Oracle APEX, Oracle AI Vision Service, and Oracle Autonomous Database.  

We’ll share how we trained our AI Machine learning models with X-Ray mammography images to identify breast cancers and even incorporated many other features, such as helping doctors or patients dictate medical symptoms and diagnoses quickly by sending an email of the audio message and the medical transcription text.  
 
Estimated Workshop Time: 4 hours

### Objectives

In this workshop, you will learn how to:

* Provision Oracle Autonomous Database
* Upload X-Ray Image to OCI Object storage and detect Breast Cancer.
* Label Images using OCI Data Labeling Service
* Create and Train AI Vision Model.
* Develop Oracle Apex Application Front end for image analysis
 
#### About Breast Cancer

Breast cancer is the most diagnosed cancer among women worldwide [Breast cancer represents 1 in 4 cancers diagnosed among women globally](https://www.uicc.org/news/globocan-2020-new-global-cancer-data). Colorectal, lung, cervical, and thyroid cancers are also common among women. It is the most frequent cancer amongst both sexes and is the leading cause of death from cancer in women. The estimated 2.3 million new cases indicate that one in every eight cancers diagnosed in 2020 was breast cancer. In 2020, there were an estimated 684,996 deaths from breast cancer, with a disproportionate number of these deaths occurring in low-resource settings.

Breast cancer cells usually form a tumour that can often be seen on an x-ray or felt as a lump. It becomes advanced breast cancer if spread outside the breast through blood vessels and lymph vessels. When breast cancer spreads to other body parts (such as the liver, lungs, bones or brain), it is said to have metastasized and is referred to as metastatic breast cancer. Breast cancer is the most common cancer among women. Breast cancer occurs when some breast cells begin to grow abnormally. These cells divide more rapidly than healthy cells and continue to gather, forming a lump or mass. The cells may spread (metastasize) to the lymph nodes or other body parts. Breast cancer mostly begins with cells in the milk-producing ducts (invasive ductal carcinoma), the glandular tissue called lobules (invasive lobular carcinoma), or other cells or tissue within the breast.

Researchers have identified hormonal, lifestyle and environmental factors that may increase the risk of breast cancer. But it is unclear why some women without risk factors develop cancer, yet others with risk factors never do. It is most likely that a complex interaction of genetic makeup and environmental factors causes breast cancer.
 
 ![Women's Cancer 2020](images/womens-cancer.png =50%x* )

#### About Lung Cancer

Cancer is a disease in which cells in the body grow out of control. When cancer starts in the lungs, it is called lung cancer Worldwide, lung cancer is the second most commonly diagnosed cancer. NSCLC is the most common type of lung cancer in the United States, accounting for 81% of all lung cancer diagnoses.

In 2023, an estimated [238,340 adults (117,550 men and 120,790 women)](https://www.cancer.net/cancer-types/lung-cancer-non-small-cell/statistics) in the United States will be diagnosed with lung cancer. Worldwide, an estimated 2,206,771 people were diagnosed with lung cancer in 2020. These statistics include both small cell lung cancer and NSCLC.

Lung cancer begins in the lungs and may spread to lymph nodes or other organs in the body, such as the brain. Cancer from other organs also may spread to the lungs. When cancer cells spread from one organ to another, they are called metastases.

Lung cancers usually are grouped into two main types called small cell and non-small cell (including adenocarcinoma and squamous cell carcinoma). These types of lung cancer grow differently and are treated differently. Non-small cell lung cancer is more common than small cell lung cancer. For more information, visit the National Cancer Institute’s

Lung cancer includes two main types: non-small cell lung cancer and small cell lung cancer. Smoking causes most lung cancers, but nonsmokers can also develop lung cancer.  

[Lung cancer and prostate cancer are the most common among men](https://www.uicc.org/news/globocan-2020-new-global-cancer-data), together accounting for nearly one-third of all male cancers.

![Mens's Lung Cancer 2020](images/lungcancer.png =50%x* )

### Prerequisites (Optional)
 
This lab assumes you have:

* An Oracle account
* Basic Developer Knowledge of Oracle APEX and Oracle PL/SQL

You may now **proceed to the next lab**.
    
## Acknowledgements

* **Author** - Madhusudhan Rao B M, Principal Product Manager, Oracle Database
* **Contributors** - Bo English-Wiczling, Senior Direct, Program Management, Oracle Database 
* **Last Updated By/Date** - June 9th, 2023
