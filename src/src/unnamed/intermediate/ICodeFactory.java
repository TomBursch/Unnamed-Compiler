package unnamed.intermediate;

import unnamed.intermediate.icodeimpl.ICodeImpl;
import unnamed.intermediate.icodeimpl.ICodeNodeImpl;

/**
 * <h1>ICodeFactory</h1>
 *
 * <p>A factory for creating objects that implement the unnamed.intermediate code.</p>
 *
 * <p>Copyright (c) 2009 by Ronald Mak</p>
 * <p>For instructional purposes only.  No warranties.</p>
 */
public class ICodeFactory
{
    /**
     * Create and return an unnamed.intermediate code implementation.
     * @return the unnamed.intermediate code implementation.
     */
    public static ICode createICode()
    {
        return new ICodeImpl();
    }

    /**
     * Create and return a node implementation.
     * @param type the node type.
     * @return the node implementation.
     */
    public static ICodeNode createICodeNode(ICodeNodeType type)
    {
        return new ICodeNodeImpl(type);
    }
}
