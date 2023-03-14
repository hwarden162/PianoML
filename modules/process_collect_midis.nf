process CollectMidis {
    input:
    file files

    output:
    path out 

    script:
    """
    mkdir out
    cp -r ${files} out
    """
}