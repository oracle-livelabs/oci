# Preparing the model

## Introduction

We're getting to the fun part! We need to download the Mistral model now which is the key part of the project that enables the crew to chat with the onboard expert. 

Estimated Time: 10 minutes


### Objectives
In this lab, you will:
- Build the project environment
- Build the project itself
- Test the project

## Task 1: Build the project environment  

1. Build the project environment:  
Make certain you are in the llama.cpp directory.  
Run the following commands to build the project environment:
```
<copy>
cd ~/llama.cpp
cmake -S . -B build -DLLAMA_CUDA=on
</copy>
```
This process prepares the framework and creates the environment in a new directory called ‘build’ inside llama.cpp (~\llama.cpp\build)  
DLLAMA_CUDA=on is critical if you want to use the GPU instead of CPU  
**If you do not have a GPU and want to run the model using CPU only, change this to:**  

```cmake -S . -B build -DLLAMA_CUDA=off```

The output should resemble the following:
```
ubuntu@ubuntua10-1:~/llama.cpp$ cmake -S . -B build -DLLAMA_CUDA=on
-- The C compiler identification is GNU 13.3.0
-- The CXX compiler identification is GNU 13.3.0
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Check for working C compiler: /usr/bin/cc - skipped
-- Detecting C compile features
-- Detecting C compile features - done
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Check for working CXX compiler: /usr/bin/c++ - skipped
-- Detecting CXX compile features
-- Detecting CXX compile features - done
(output truncated)
```

1. Build the actual project   
Run the following command:
```
<copy>
cd ~/llama.cpp
cmake --build build --config Release -j $(nproc)
</copy>
```

The output should resemble the following:
```
ubuntu@ubuntua10-1:~/llama.cpp$ cmake --build build --config Release -j $(nproc)
[  0%] Generating build details from Git
[  1%] Building C object ggml/src/CMakeFiles/ggml-base.dir/ggml.c.o
[  2%] Building C object examples/gguf-hash/CMakeFiles/sha256.dir/deps/sha256/sha256.c.o
[  2%] Building C object ggml/src/CMakeFiles/ggml-base.dir/ggml-alloc.c.o
[  2%] Building CXX object ggml/src/CMakeFiles/ggml-base.dir/ggml-backend.cpp.o
[  3%] Building C object examples/gguf-hash/CMakeFiles/xxhash.dir/deps/xxhash/xxhash.c.o
[  4%] Building CXX object ggml/src/CMakeFiles/ggml-base.dir/ggml-threading.cpp.o
[  4%] Building CXX object ggml/src/CMakeFiles/ggml-base.dir/ggml-opt.cpp.o
[  4%] Building C object examples/gguf-hash/CMakeFiles/sha1.dir/deps/sha1/sha1.c.o
[  4%] Building CXX object examples/llava/CMakeFiles/llama-llava-cli.dir/deprecation-warning.cpp.o
[  4%] Building C object ggml/src/CMakeFiles/ggml-base.dir/ggml-quants.c.o
[  4%] Building CXX object examples/llava/CMakeFiles/llama-minicpmv-cli.dir/deprecation-warning.cpp.o
[  5%] Building CXX object examples/llava/CMakeFiles/llama-gemma3-cli.dir/depreca
(output truncated)
```
**Protip**: If you are the curious type who likes to tinker and have a system with a GPU  
you can easily see the difference in model performance when running on CPU-only vs GPU-assisted.  
To do this, simply create two different build directories. In the last two steps above,  
we created a directory structure in llamap.cpp called "build" and it was for GPU. But we could do something like this:  
```
cmake -S . -B build-cpu -DLLAMA_CUDA=off
cmake --build build-cpu --config Release -j $(nproc)

cmake -S . -B build-gpu -DLLAMA_CUDA=on
cmake --build build-gpu --config Release -j $(nproc)
```
This would create two distinct build folders and you can execute the same model using either type of inference build.  
All of the commands in the labs that follow will reference the build folder - BUT you can change it at execution time to use the -CPU or -GPU folders if you like. 

## Task 2: Downloading the model

1. We need a quantized model because the destination GPU onboard the NovaSystems spacecraft will have limited VRAM. Quantized models squeeze the model size down by removing some of the detail. If you needed to move a 10,000 piece Death Star lego set to your friend's house, you could move the entire thing with every tiny detailed piece accounted for. But if you have to do this a few times, it would be far easier to swap out some of the tiny pieces for larger blocks making it easier to transport and rebuild. You still get the whole Death Star, just not in as much detail as before if you really look closely. 

    Run the following command to download the model:
    ```
    <copy>
    cd ~/llama.cpp/models
    sudo wget https://huggingface.co/TheBloke/Mistral-7B-Instruct-v0.1-GGUF/resolve/main/mistral-7b-instruct-v0.1.Q4_K_M.gguf
    cd ..
    </copy>
    ```

    Your output should resemble the following:
    ```
    ubuntu@ubuntua10-1:~/llama.cpp$ cd ~/llama.cpp/models
    sudo wget https://huggingface.co/TheBloke/Mistral-7B-Instruct-v0.1-GGUF/resolve/main/mistral-7b-instruct-v0.1.Q4_K_M.gguf
    cd ..
    --2025-05-01 22:15:47--  https://huggingface.co/TheBloke/Mistral-7B-Instruct-v0.1-GGUF/resolve/main/mistral-7b-instruct-v0.1.Q4_K_M.gguf
    Resolving huggingface.co (huggingface.co)... 3.167.112.96, 3.167.112.45, 3.167.112.38, ...
    Connecting to huggingface.co (huggingface.co)|3.167.112.96|:443... connected.
    HTTP request sent, awaiting response... 302 Found
    Location: https://cdn-lfs.hf.co/repos/46/12/46124cd8d4788fd8e0879883abfc473f247664b987955cc98a08658f7df6b826/14466f9d658bf4a79f96c3f3f22759707c291cac4e62fea625e80c7
    (output truncated)
    ```

## Task 3: Running the Model

1.  Now lets test our model with the following command. Notice that the end of the command asks the model a question about the sun:
    ```
    <copy>
    ~/llama.cpp/build/bin/llama-cli -m models/mistral-7b-instruct-v0.1.Q4_K_M.gguf --n-gpu-layers 100 -p "Briefly, Why is the sun yellow?"
    </copy>
   ```
   Toward the bottom of the output, you should see the model answer the question, like this:

    ```
     Briefly, Why is the sun yellow?

The sun appears yellow because its surface temperature is about 5,500 degrees Celsius (9,932 degrees Fahrenheit), which causes the hydrogen atoms in its surface to emit green light. However, the Earth's atmosphere scatters the shorter, blue wavelengths of light more than the longer, yellow and red wavelengths, causing the sun to appear yellow or orange when viewed from the surface. [end of text]
    ```

2. Now let's interactively chat with the model for some additional testing. Feel free to ask whatever you’d like.  
Please note that the model is not fine-tuned or tailored to our use case yet so it’s responses will vary each time you run it.  
  
    ```
    <copy>
    ~/llama.cpp/build/bin/llama-cli -m models/mistral-7b-instruct-v0.1.Q4_K_M.gguf --n-gpu-layers 100 --interactive-first --color
    </copy>
    ```
    Just for fun, try to get the model to hold context in a chat. Your results ~~may~~ will vary 😊
 . 
T minus 2  

*Congratulations! You have successfully completed the lab.*
You may now **proceed to the next lab**.

## Acknowledgements
* **Author** - Jeff Allen, Distinguished Cloud Architect, AI Accounts
* **Contributors** -  Animesh Sahay, Enterprise Cloud Engineering
* **Last Updated:** - May 2025
